terraform {
  required_providers {
    aci = {
      source  = "CiscoDevNet/aci"
      version = ">=2.0.0"
    }
  }
  # experiments = [module_variable_optional_attrs]
}

locals {
  epg_dn = var.epg_map[var.mapping.selected_epg.epg_name].id
  esg_dn = var.esg_map[var.mapping.mapped_esg.esg_name].id
}

# ### Load Mapped ESG ###
# data "aci_endpoint_security_group" "mapped_esg" {
#   application_profile_dn    = var.mapping.ap.id
#   name                      = var.mapping.mapped_esg.esg_name
# }
#
# ### Load Mapped EPG ###
# data "aci_application_epg" "selected_epg" {
#   application_profile_dn    = var.mapping.ap.id
#   name                      = var.mapping.selected_epg.epg_name
# }

### Map EPGs to ESGs if ESG Selected ###
resource "aci_endpoint_security_group_epg_selector" "epg_esg" {

  endpoint_security_group_dn  = local.esg_dn #data.aci_endpoint_security_group.mapped_esg.id
  match_epg_dn                = local.epg_dn #data.aci_application_epg.selected_epg.id
}
