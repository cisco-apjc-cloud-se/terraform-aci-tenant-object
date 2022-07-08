terraform {
  required_providers {
    aci = {
      source  = "CiscoDevNet/aci"
      version = ">=2.0.0"
    }
  }
  # experiments = [module_variable_optional_attrs]
}

### L3 Subnet for Bridge Domain(s) ###
resource "aci_subnet" "subnet" {
  parent_dn           = var.parent_dn
  description         = var.subnet.description
  ip                  = var.subnet.ip
  scope               = var.subnet.scope # ["public"]
  preferred           = var.subnet.preferred
}
