terraform {
  required_providers {
    aci = {
      source  = "CiscoDevNet/aci"
      version = ">=2.0.0"
    }
  }
  # experiments = [module_variable_optional_attrs]
}

### L3Out Configured Node ###
resource "aci_logical_node_to_fabric_node" "nodes" {
  logical_node_profile_dn = var.lprof_dn
  tdn                     = format("topology/pod-%d/node-%d", var.node.pod, var.node.leaf_node)
  rtr_id                  = var.node.loopback_ip
}
