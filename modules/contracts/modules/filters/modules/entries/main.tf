terraform {
  required_providers {
    aci = {
      source  = "CiscoDevNet/aci"
      version = ">=2.0.0"
    }
  }
  experiments = [module_variable_optional_attrs]
}

### Add entry to new or existing Filter ###

resource "aci_filter_entry" "entry" {
  filter_dn     = var.filter_dn
  description   = var.entry.description
  name          = var.entry.name
  ether_t       = var.entry.ether_t
  d_from_port   = var.entry.d_from_port
  d_to_port     = var.entry.d_to_port
  prot          = var.entry.prot
  s_from_port   = var.entry.s_from_port
  s_to_port     = var.entry.s_to_port
}
