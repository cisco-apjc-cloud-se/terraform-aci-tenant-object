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
  interface_profile = defaults(var.interface_profile, {
    use_existing = false
    ospf_profile = {
      enabled = false
    }
    })
}

### Load existing Logical Profile ###
data "aci_logical_interface_profile" "intprof" {
  count = local.interface_profile.use_existing == true ? 1 : 0

  logical_node_profile_dn = var.lprof_dn
  name                    = local.interface_profile.intprof_name
}

### Create new L3Out Logical Profiles ###
resource "aci_logical_interface_profile" "intprof" {
  count = local.interface_profile.use_existing == false ? 1 : 0

  logical_node_profile_dn = var.lprof_dn
  name                    = local.interface_profile.intprof_name
  description             = local.interface_profile.description
}

### ACI Interface Profile Paths Module ###
module "paths" {
  for_each = local.interface_profile.paths
  source = "./modules/paths"

  ### VARIABLES ###
  intprof_dn  = local.interface_profile.use_existing == true ? data.aci_logical_interface_profile.intprof[0].id : aci_logical_interface_profile.intprof[0].id
  path        = each.value
}

### ACI Interface Profile Floating SVIs Module ###
module "floating_svis" {
  for_each = local.interface_profile.floating_svis
  source = "./modules/floating_svis"

  ### VARIABLES ###
  intprof_dn    = local.interface_profile.use_existing == true ? data.aci_logical_interface_profile.intprof[0].id : aci_logical_interface_profile.intprof[0].id
  floating_svi  = each.value
}

### OSPF Interface Profile ###
data "aci_tenant" "tenant" {
  count = local.interface_profile.ospf_profile.enabled == true && local.interface_profile.ospf_profile.ospf_policy.tenant_name != null ? 1 : 0 # && local.interface_profile.ospf_profile.ospf_policy != null

  name        = local.interface_profile.ospf_profile.ospf_policy.tenant_name
}

data "aci_ospf_interface_policy" "ospf" {
   count = local.interface_profile.ospf_profile.enabled == true && local.interface_profile.ospf_profile.ospf_policy.policy_name != null ? 1 : 0

   name      = local.interface_profile.ospf_profile.ospf_policy.policy_name
   tenant_dn = local.interface_profile.ospf_profile.ospf_policy.tenant_name != null ? data.aci_tenant.tenant[0].id : var.tenant.id
}

resource "aci_l3out_ospf_interface_profile" "ospf" {
  count = local.interface_profile.ospf_profile.enabled == true ? 1 : 0

  logical_interface_profile_dn = local.interface_profile.use_existing == true ? data.aci_logical_interface_profile.intprof[0].id : aci_logical_interface_profile.intprof[0].id
  description                  = local.interface_profile.ospf_profile.description
  auth_key                     = local.interface_profile.ospf_profile.auth_key
  auth_key_id                  = local.interface_profile.ospf_profile.auth_key_id
  auth_type                    = local.interface_profile.ospf_profile.auth_type
  relation_ospf_rs_if_pol      = local.interface_profile.ospf_profile.ospf_policy.policy_name != null ? data.aci_ospf_interface_policy.ospf[0].id : null
}
