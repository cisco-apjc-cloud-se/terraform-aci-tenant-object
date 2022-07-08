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
  bd = defaults(var.bd, {
    use_existing = false
    })

  # l3out_external_tenants = distinct([for k,l in local.bd.l3outs : l.tenant_name if l.tenant_name != null ])

  ### L3Out Processing ###
  external_l3outs = {
    for k,l in local.bd.l3outs :
    k => l
    if l.tenant_name != null
  }

  internal_l3outs = {
    for k,l in local.bd.l3outs :
    k => l
    if l.tenant_name == null
  }

  l3outs = merge({
    for k,l in local.external_l3outs :
      k => {
        l3out_name = l.l3out_name
        id = data.aci_l3_outside.external_l3outs[k].id
      }
  },
  {
    for k,l in local.internal_l3outs :
      k => {
        l3out_name = l.l3out_name
        id = var.l3out_map[l.l3out_name].id
      }
  })


  }

### External L3Out Tenants ###
data "aci_tenant" "l3out_external_tenants" {
  for_each = local.external_l3outs

  name        = each.value.tenant_name
}

### Load External L3Outs ###
data "aci_l3_outside" "external_l3outs" {
  for_each = local.external_l3outs

  name      = each.value.l3out_name
  tenant_dn = data.aci_tenant.l3out_external_tenants[each.key]
}


### Load Existing BDs ###
data "aci_bridge_domain" "bd" {
  count = local.bd.use_existing == true ? 1 : 0

  name         = local.bd.bd_name
  tenant_dn    = var.tenant.id

}

### Load Existing VRF by Tenant & Name ###
data "aci_tenant" "vrf_external_tenant" {
  count = local.bd.vrf.tenant_name != null ? 1 : 0

  name        = local.bd.vrf.tenant_name
}

data "aci_vrf" "external_vrf" {
  count = local.bd.vrf.tenant_name != null ? 1 : 0

  name         = local.bd.vrf.vrf_name
  tenant_dn    = data.aci_tenant.vrf_external_tenant[0].id
}

### Create new Bridge Domain(s) in Tenant VRF(s) ###
resource "aci_bridge_domain" "bd" {
  count = local.bd.use_existing == false ? 1 : 0

  tenant_dn                   = var.tenant.id
  description                 = local.bd.description
  name                        = local.bd.bd_name
  arp_flood                   = local.bd.arp_flood # "yes", "no"
  mac                         = local.bd.mac_address
  # unk_mac_ucast_act           = each.value.unk_mac_ucast_act != null ? each.value.unk_mac_ucast_act : "opt-proxy"  Need to test
  relation_fv_rs_ctx          = local.bd.vrf.tenant_name != null ? data.aci_vrf.external_vrf[0].id : var.vrf_map[local.bd.vrf.vrf_name].id
  relation_fv_rs_bd_to_out    = [for k,l in local.l3outs: l.id ]
}


### Subnets Module ###
module "subnets" {
  for_each = local.bd.subnets
  source = "./modules/subnets"

  ### Variables ###
  parent_dn = try(aci_bridge_domain.bd[0].id, data.aci_bridge_domain.bd[0].id)
  subnet    = each.value
}
