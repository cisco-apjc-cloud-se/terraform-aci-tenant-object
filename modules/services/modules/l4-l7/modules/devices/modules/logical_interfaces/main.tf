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
  concrete_interfaces_list = flatten([
    for d_key, device in var.int_map : [
      for i_key, interface in device.int_map : [
        {
          d_key           = d_key
          i_key           = i_key
          interface_name  = interface.name
          interface_id    = interface.id
        }
      ]
    ]
  ])

  selected_list = [
    for interface in local.concrete_interfaces_list :
      interface.interface_id
    if interface.interface_name == var.interface.interface_name
  ]
}

resource "aci_l4_l7_logical_interface" "int" {
  l4_l7_device_dn             = var.l4_l7_dn
  name                        = var.interface.interface_name
  annotation                  = var.interface.annotation
  encap                       = var.interface.encap
  enhanced_lag_policy_name    = var.interface.enhanced_lag_policy_name
  relation_vns_rs_c_if_att_n  = local.selected_list # list of concrete interface IDs
}
