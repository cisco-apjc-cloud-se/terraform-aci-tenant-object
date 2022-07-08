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
  # service_redirect_policies = defaults(var.tenant.policies.service_redirect_policies, {
  #   use_existing = false
  #   })

  # ### Service Redirect Policies Name => ID Lookup Map ###
  # srp_map = {
  #   for k,p in var.policies.service_redirect_policies:
  #     k => {
  #       id    = module.service_redirect_policies[k].policy_id
  #       name  = p.policy_name
  #     }
  #   }

}

## ACI L4-L7 Module ##
module "l4-l7" {
  source = "./modules/l4-l7"

  ### Variables ###
  l4-l7   = var.services.l4-l7
  tenant  = var.tenant
}
