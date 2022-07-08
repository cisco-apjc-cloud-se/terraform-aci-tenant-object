terraform {
  required_providers {
    aci = {
      source  = "CiscoDevNet/aci"
      version = ">=2.0.0"
    }
  }
  experiments = [module_variable_optional_attrs]
}

resource "aci_destination_of_redirected_traffic" "destination" {
  service_redirect_policy_dn  = var.service_redirect_policy_dn
  ip                          = var.destination.ip
  mac                         = var.destination.mac
  annotation                  = var.destination.annotation
  description                 = var.destination.description
  ip2                         = var.destination.ip2
  dest_name                   = var.destination.dest_name
  pod_id                      = var.destination.pod_id
  name_alias                  = var.destination.name_alias

  relation_vns_rs_redirect_health_group = var.destination.health_group != null ? var.health_group_map[var.destination.health_group].id : null
}
