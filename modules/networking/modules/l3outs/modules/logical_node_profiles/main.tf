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
  logical_node_profile = defaults(var.logical_node_profile, {
    use_existing = false
    })
}

### Load existing Logical Profile ###
data "aci_logical_node_profile" "lprof" {
  count = local.logical_node_profile.use_existing == true ? 1 : 0

  l3_outside_dn = var.l3out_dn
  name = local.logical_node_profile.lprof_name
}

### Create new L3Out Logical Profiles ###
resource "aci_logical_node_profile" "lprof" {
  count = local.logical_node_profile.use_existing == false ? 1 : 0

  l3_outside_dn = var.l3out_dn
  description   = local.logical_node_profile.description
  name          = local.logical_node_profile.lprof_name
}

### ACI Logical Interface Profiles Module ###
module "interface_profiles" {
  for_each = local.logical_node_profile.interface_profiles
  source = "./modules/interface_profiles"

  ### VARIABLES ###
  lprof_dn          = local.logical_node_profile.use_existing == true ? data.aci_logical_node_profile.lprof[0].id : aci_logical_node_profile.lprof[0].id
  interface_profile = each.value
  tenant            = var.tenant
}

### ACI Logical Interface Nodes Module ###
module "nodes" {
  for_each = local.logical_node_profile.nodes
  source = "./modules/nodes"

  ### VARIABLES ###
  lprof_dn  = local.logical_node_profile.use_existing == true ? data.aci_logical_node_profile.lprof[0].id : aci_logical_node_profile.lprof[0].id
  node      = each.value
}

### ACI BGP Peer Profiles Module ###
module "bgp_peers" {
  for_each = local.logical_node_profile.bgp_peers
  source = "./modules/bgp_peers"

  ### VARIABLES ###
  lprof_dn  = local.logical_node_profile.use_existing == true ? data.aci_logical_node_profile.lprof[0].id : aci_logical_node_profile.lprof[0].id
  bgp_peer  = each.value
}
