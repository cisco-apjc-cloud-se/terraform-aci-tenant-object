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

  ### Service Graph Template -> ID Lookup Map ###
  sgt_map = {
    for k,t in var.l4-l7.service_graph_templates:
      k => {
        id    = module.service_graph_templates[k].template_id
        name  = t.template_name
      }
    }

  ### Device Name => ID Lookup Map ###
  device_map = {
    for k,d in var.l4-l7.devices:
      k => {
        id              = module.devices[k].device_id
        logical_int_map = module.devices[k].logical_int_map
        name            = d.device_name
      }
    }

}

## ACI L4-L7 Devices Module ##
module "devices" {
  for_each = var.l4-l7.devices
  source = "./modules/devices"

  ### Variables ###
  device   = each.value
  tenant   = var.tenant
}


## ACI L4-L7 Service Graph Templates Module ##
module "service_graph_templates" {

  for_each = var.l4-l7.service_graph_templates
  source = "./modules/service_graph_templates"

  ### Variables ###
  service_graph_template  = each.value
  tenant                  = var.tenant
  device_map              = local.device_map
}
