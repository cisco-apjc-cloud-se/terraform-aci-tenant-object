terraform {
  required_providers {
    aci = {
      source  = "CiscoDevNet/aci"
      version = ">=2.0.0"
    }
  }
  experiments = [module_variable_optional_attrs]
}

## Build Tenant Lookup List ##
locals {
  contract_tenants = distinct(concat([for k,c in var.esg.consumed_contracts : c.tenant_name if c.tenant_name != null ],[for k,c in var.esg.provided_contracts : c.tenant_name if c.tenant_name != null ]))

  ### Modified Contracts ###
  external_consumed_contracts = {
    for k,c in var.esg.consumed_contracts :
      k => c
    if c.tenant_name != null
  }
  external_provided_contracts = {
    for k,c in var.esg.provided_contracts :
      k => c
    if c.tenant_name != null
  }
  internal_consumed_contracts = {
    for k,c in var.esg.consumed_contracts :
      k => c
    if c.tenant_name == null
  }
  internal_provided_contracts = {
    for k,c in var.esg.provided_contracts :
      k => c
    if c.tenant_name == null
  }

  consumed_contracts = merge({
    for k,c in local.external_consumed_contracts:
      k => {
        contract_name = c.contract_name
        id = data.aci_contract.external_consumed_contracts[c.contract_name].id
      }
  },
  {
    for k,c in local.internal_consumed_contracts:
      k => {
        contract_name = c.contract_name
        id = var.contract_map[c.contract_name].id
      }
  })
  provided_contracts = merge({
    for k,c in local.external_provided_contracts:
      k => {
        contract_name = c.contract_name
        id = data.aci_contract.external_provided_contracts[c.contract_name].id
      }
  },
  {
    for k,c in local.internal_provided_contracts:
      k => {
        contract_name = c.contract_name
        id = var.contract_map[c.contract_name].id
      }
  })
}

data "aci_tenant" "contract_tenants" {
  for_each = toset(local.contract_tenants)
  name        = each.value
}

data "aci_contract" "external_consumed_contracts" {
  for_each = local.external_consumed_contracts

  tenant_dn   = each.value.tenant_name != null ? data.aci_tenant.contract_tenants[each.value.tenant_name].id : var.tenant_dn
  name        = each.value.contract_name
}

data "aci_contract" "external_provided_contracts" {
  for_each = local.external_provided_contracts

  tenant_dn   = each.value.tenant_name != null ? data.aci_tenant.contract_tenants[each.value.tenant_name].id : var.tenant_dn
  name        = each.value.contract_name
}

### Load Existing VRF by Tenant & Name ###
data "aci_tenant" "tenant" {
  count = var.esg.vrf.tenant_name != null ? 1 : 0

  name        = var.esg.vrf.tenant_name
}

data "aci_vrf" "vrf" {
  count = var.esg.vrf.tenant_name != null ? 1 : 0
  name         = var.esg.vrf.vrf_name
  tenant_dn    = data.aci_tenant.tenant[0].id
}

# ### Load existing ESG ###
data "aci_endpoint_security_group" "esg" {
  count = var.esg.use_existing == true ? 1 : 0

  application_profile_dn    = var.ap.id
  name                      = var.esg.esg_name
}

### Create new Endpoint Security Group(s) ###

resource "aci_endpoint_security_group" "esg" {
  count = var.esg.use_existing == false ? 1 : 0

  application_profile_dn    = var.ap.id
  name                      = var.esg.esg_name
  description               = var.esg.description
  pref_gr_memb              = var.esg.preferred_group
  relation_fv_rs_scope      = var.esg.vrf.tenant_name != null ? data.aci_vrf.vrf[0].id : var.vrf_map[var.esg.vrf.vrf_name].id

  dynamic "relation_fv_rs_cons" {
    for_each = local.consumed_contracts #var.esg.consumed_contracts
    content {
      prio      = "unspecified" # Requried?
      target_dn = relation_fv_rs_cons.value.id #data.aci_contract.consumed_contracts[relation_fv_rs_cons.key].id
    }
  }

  dynamic "relation_fv_rs_prov" {
    for_each = local.provided_contracts #var.esg.provided_contracts
    content {
      prio      = "unspecified" # Requried?
      match_t   = "AtleastOne"  # Required?
      target_dn = relation_fv_rs_prov.value.id #data.aci_contract.provided_contracts[relation_fv_rs_prov.key].id
    }
  }

}
