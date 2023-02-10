terraform {
  required_providers {
    aci = {
      source  = "CiscoDevNet/aci"
      version = ">=2.0.0"
    }
  }
  experiments = [module_variable_optional_attrs]
}

resource "aci_concrete_interface" "int" {
  concrete_device_dn            = var.concrete_dn
  name                          = var.interface.interface_name
  encap                         = var.interface.encap #"unknown"
  vnic_name                     = var.domain.type == "vmware" ? var.interface.vnic_name : null  # "Network adapter 5"
  relation_vns_rs_c_if_path_att = var.domain.type == "physical" ? format("topology/pod-%d/paths-%d/pathep-[%s]", var.interface.pod, var.interface.node, var.interface.port) : null
}
