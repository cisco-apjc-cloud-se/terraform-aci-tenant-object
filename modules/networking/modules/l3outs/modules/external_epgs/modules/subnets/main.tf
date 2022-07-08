terraform {
  required_providers {
    aci = {
      source  = "CiscoDevNet/aci"
      version = ">=2.0.0"
    }
  }
  # experiments = [module_variable_optional_attrs]
}

# NOTE: Only deploys managed subnets - lowest level
resource "aci_l3_ext_subnet" "extsubnets" {
  external_network_instance_profile_dn  = var.external_epg_dn
  description                           = var.subnet.description
  aggregate                             = var.subnet.aggregate # "import-rtctrl", "export-rtctrl","shared-rtctrl" and "none".
  ip                                    = var.subnet.ip
  scope                                 = var.subnet.scope #["import-security"], ["import-security","shared-security"]
}
