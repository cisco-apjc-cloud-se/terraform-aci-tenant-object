terraform {
  required_providers {
    aci = {
      source  = "CiscoDevNet/aci"
      version = ">=2.0.0"
    }
  }
  experiments = [module_variable_optional_attrs]
}

### Locals ###
locals {
  ### Set Optional Defaults ###
  external_epg = defaults(var.external_epg, {
    use_existing = false
    })

    contract_tenants = distinct(concat([for k,c in local.external_epg.consumed_contracts : c.tenant_name if c.tenant_name != null ],[for k,c in local.external_epg.provided_contracts : c.tenant_name if c.tenant_name != null ]))

    ### Modified Contracts ###
    external_consumed_contracts = {
      for k,c in local.external_epg.consumed_contracts :
        k => c
      if c.tenant_name != null
    }
    external_provided_contracts = {
      for k,c in local.external_epg.provided_contracts :
        k => c
      if c.tenant_name != null
    }
    internal_consumed_contracts = {
      for k,c in local.external_epg.consumed_contracts :
        k => c
      if c.tenant_name == null
    }
    internal_provided_contracts = {
      for k,c in local.external_epg.provided_contracts :
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

  tenant_dn   = each.value.tenant_name != null ? data.aci_tenant.contract_tenants[each.value.tenant_name].id : var.tenant.id
  name        = each.value.contract_name
}

data "aci_contract" "external_provided_contracts" {
  for_each = local.external_provided_contracts

  tenant_dn   = each.value.tenant_name != null ? data.aci_tenant.contract_tenants[each.value.tenant_name].id : var.tenant.id
  name        = each.value.contract_name
}

### Load existing External EPG ###
data "aci_external_network_instance_profile" "extepg" {
  count = local.external_epg.use_existing == true ? 1 : 0

  l3_outside_dn = var.l3out_dn
  name          = local.external_epg.extepg_name

}

## Load existing External EPG for Inherited EPG - local only, no tenant option anyway ##
## NOTE: L3outs MUST exist first
data "aci_l3_outside" "contract_masters" {
  for_each = local.external_epg.contract_master_epgs

  name      = each.value.l3out_name
  tenant_dn = var.tenant.id
}

## NOTE: ExEPG MUST exist first
data "aci_external_network_instance_profile" "contract_masters" {
  for_each = local.external_epg.contract_master_epgs

  l3_outside_dn = data.aci_l3_outside.contract_masters[each.key].id
  name          = each.value.extepg_name
}


### Create new External EPG ###
resource "aci_external_network_instance_profile" "extepg" {
  ### External EPGs with No Inherited Contract Master EPGs ###
  count = local.external_epg.use_existing == false ? 1 : 0 # && length(local.external.relation_fv_rs_sec_inherited) == 0

  l3_outside_dn       = var.l3out_dn
  description         = local.external_epg.description
  name                = local.external_epg.extepg_name
  pref_gr_memb        = local.external_epg.preferred_group

  relation_fv_rs_cons = [
    for k,c in local.consumed_contracts: c.id
  ]
  relation_fv_rs_prov = [
    for k,c in local.provided_contracts: c.id
  ]

  # ### Inherited Contract Masters ###
  # relation_fv_rs_sec_inherited = [
  #   for k,e in local.external_epg.contract_master_epgs : data.aci_external_network_instance_profile.contract_masters[k].id
  # ]

}

### ACI External EPG Subnets Module ###
module "subnets" {
  for_each = local.external_epg.subnets
  source = "./modules/subnets"

  ### Variables ###
  external_epg_dn = local.external_epg.use_existing == true ? data.aci_external_network_instance_profile.extepg[0].id : aci_external_network_instance_profile.extepg[0].id
  subnet          = each.value
}
