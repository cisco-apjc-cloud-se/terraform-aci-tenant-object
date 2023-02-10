terraform {
  required_providers {
    aci = {
      source  = "CiscoDevNet/aci"
      version = ">=2.0.0"
    }
  }
  experiments = [module_variable_optional_attrs]
}

locals {
  bd_dn = var.bd_map[var.epg.bd.bd_name].id
  bd_name = var.bd_map[var.epg.bd.bd_name].name

  ### DPG Map ###
  dpg_map = {
    for k,d in var.epg.domains :
      k => {
        dpg_id = module.domains[k].dpg_id
        dpg_name = module.domains[k].dpg_name
      }
    if d.type == "vmware"
  }
}

### Load Existing BD by Tenant & Name ###
data "aci_tenant" "tenant" {
  count = var.epg.bd.tenant_name != null ? 1 : 0

  name        = var.epg.bd.tenant_name
}

data "aci_bridge_domain" "bd" {
  count = var.epg.bd.tenant_name != null ? 1 : 0
  name         = var.epg.bd.bd_name
  tenant_dn    = data.aci_tenant.tenant[0].id
}


### Load existing EPG ###
data "aci_application_epg" "epg" {
  count = var.epg.use_existing == true ? 1 : 0

  application_profile_dn    = var.ap.id
  name                      = var.epg.epg_name

}

### Create New EPG(s) for AP(s) ###
resource "aci_application_epg" "epg" {
  count = var.epg.use_existing == false ? 1 : 0

  application_profile_dn    = var.ap.id
  name                      = var.epg.epg_name
  description               = var.epg.description
  pref_gr_memb              = var.epg.preferred_group
  relation_fv_rs_bd         = var.epg.bd.tenant_name != null ? data.aci_bridge_domain.bd[0].id : local.bd_dn
  # relation_fv_rs_bd         = local.bd_dn

  # relation_fv_rs_aepg_mon_pol = ""
  # relation_fv_rs_dpp_pol      = ""
  # relation_fv_rs_path_att     = []
  # relation_fv_rs_trust_ctrl   = ""

  lifecycle {
    ignore_changes = [pref_gr_memb]
  }
}

module "static_paths" {
  for_each = var.epg.paths
  source = "./modules/static_paths"

  ### Variables ###
  path = each.value
  epg_id = try(aci_application_epg.epg[0].id, data.aci_application_epg.epg[0].id)

}

module "domains" {
  for_each = var.epg.domains
  source = "./modules/domains"

  ### Variables ###
  domain = each.value
  epg_id = try(aci_application_epg.epg[0].id, data.aci_application_epg.epg[0].id)

  tenant_name = var.tenant_name
  ap_name     = var.ap.name
  epg_name    = var.epg.epg_name

}
