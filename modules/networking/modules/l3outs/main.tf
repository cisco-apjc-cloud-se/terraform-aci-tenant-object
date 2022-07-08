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
  l3out = defaults(var.l3out, {
    use_existing = false
    ospf_policy = {
      enabled = false
    }
    })

  ### VRF Name => ID Lookup Map ###
  extepg_map = {
    for k, e in local.l3out.external_epgs :
      k => {
        id    = module.external_epgs[k].extepg_id
        name  = e.extepg_name
      }
    }
}

### Lookup existing L3 domain ###
data "aci_l3_domain_profile" "l3domain" {
  name = local.l3out.l3_domain
}

### Load Existing L3Out ###
data "aci_l3_outside" "l3out" {
  count = local.l3out.use_existing == true ? 1 : 0

  name      = local.l3out.l3out_name
  tenant_dn = var.tenant.id
}

### Load Existing VRF by Tenant & Name ###
## Used if L3out added to existing non-local tenant & VRF (i.e. common?)

data "aci_tenant" "tenant" {
  count = local.l3out.vrf.tenant_name != null ? 1 : 0

  name        = local.l3out.vrf.tenant_name
}

data "aci_vrf" "vrf" {
  count = local.l3out.vrf.tenant_name != null ? 1 : 0

  name         = local.l3out.vrf.vrf_name
  tenant_dn    = data.aci_tenant.tenant[0].id
}

### Create new L3Out(s) in Tenant(s) ###

resource "aci_l3_outside" "l3out" {
  count = local.l3out.use_existing == false ? 1 : 0

  tenant_dn                     = var.tenant.id
  description                   = local.l3out.description
  name                          = local.l3out.l3out_name
  relation_l3ext_rs_ectx        = local.l3out.vrf.tenant_name != null ? data.aci_vrf.vrf[0].id : var.vrf_map[local.l3out.vrf.vrf_name].id  ## If non-local VRF used, use VRF data source, else use VRF map
  relation_l3ext_rs_l3_dom_att  = data.aci_l3_domain_profile.l3domain.id
}


### ACI Logical Node Profile Module ###
module "logical_node_profiles" {
  for_each = local.l3out.logical_node_profiles
  source = "./modules/logical_node_profiles"

  ### Variables ###
  l3out_dn              = local.l3out.use_existing == true ? data.aci_l3_outside.l3out[0].id : aci_l3_outside.l3out[0].id
  logical_node_profile  = each.value
  tenant                = var.tenant
}

### ACI External EPG Module ###
module "external_epgs" {
  for_each = local.l3out.external_epgs
  source = "./modules/external_epgs"

  ### Variables ###
  l3out_dn      = local.l3out.use_existing == true ? data.aci_l3_outside.l3out[0].id : aci_l3_outside.l3out[0].id
  external_epg  = each.value
  contract_map  = var.contract_map
  tenant        = var.tenant
}

### L3Out OSPF External Policy ###
resource "aci_l3out_ospf_external_policy" "ospf" {
  count = local.l3out.ospf_policy.enabled == true ? 1 : 0

  l3_outside_dn  = local.l3out.use_existing == true ? data.aci_l3_outside.l3out[0].id : aci_l3_outside.l3out[0].id
  description    = local.l3out.ospf_policy.description
  area_cost      = local.l3out.ospf_policy.area_cost
  // area_ctrl      = ["redistribute", "summary"]
  area_id        = local.l3out.ospf_policy.area_id
  area_type      = local.l3out.ospf_policy.area_type # "nssa", "regular", "stub"
}

### L3Out BGP External Policy ###
resource "aci_l3out_bgp_external_policy" "bgp" {
  count = local.l3out.bgp_policy.enabled  == true ? 1 : 0

  l3_outside_dn = local.l3out.use_existing == true ? data.aci_l3_outside.l3out[0].id : aci_l3_outside.l3out[0].id
  annotation    = local.l3out.bgp_policy.annotation
  description   = local.l3out.bgp_policy.description
  name_alias    = local.l3out.bgp_policy.name_alias
}
