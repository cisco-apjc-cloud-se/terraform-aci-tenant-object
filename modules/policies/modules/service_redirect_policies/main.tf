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
  service_redirect_policy = defaults(var.service_redirect_policy, {
    use_existing = false
    })
}

### Load Existing policy ###
data "aci_service_redirect_policy" "policy" {
  count = local.service_redirect_policy.use_existing == true ? 1 : 0

  tenant_dn = var.tenant.id
  name      = local.service_redirect_policy.policy_name
}


resource "aci_service_redirect_policy" "policy" {
  count = local.service_redirect_policy.use_existing == false ? 1 : 0

  tenant_dn               = var.tenant.id
  name                    = local.service_redirect_policy.policy_name
  name_alias              = local.service_redirect_policy.name_alias
  dest_type               = local.service_redirect_policy.dest_type
  min_threshold_percent   = local.service_redirect_policy.min_threshold_percent
  max_threshold_percent   = local.service_redirect_policy.max_threshold_percent
  hashing_algorithm       = local.service_redirect_policy.hashing_algorithm
  description             = local.service_redirect_policy.description
  anycast_enabled         = local.service_redirect_policy.anycast_enabled
  resilient_hash_enabled  = local.service_redirect_policy.resilient_hash_enabled
  threshold_enable        = local.service_redirect_policy.threshold_enable
  program_local_pod_only  = local.service_redirect_policy.program_local_pod_only
  threshold_down_action   = local.service_redirect_policy.threshold_down_action

  relation_vns_rs_ipsla_monitoring_pol = local.service_redirect_policy.ipsla_policy

}

### ACI PBR Destination Module ###
module "destinations" {
  for_each = local.service_redirect_policy.destinations
  source = "./modules/destinations"

  ### VARIABLES ###
  destination = each.value
  service_redirect_policy_dn = local.service_redirect_policy.use_existing == true ? data.aci_service_redirect_policy.policy[0].id : aci_service_redirect_policy.policy[0].id
  health_group_map = {} #NOTE: To do..

}
