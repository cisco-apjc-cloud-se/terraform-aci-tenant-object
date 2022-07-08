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
  virtual_domain = var.device.domain.type == "vmware" ? {
    dom-1 = {
      name  = var.device.domain.name
      id    = data.aci_vmm_domain.vmware[0].id
    }
  } : null

  ### Nested Interface Name => ID Lookup Map ###
  int_map = {
    for k,d in var.device.concrete_devices :
      k => {
        int_map = module.concrete_devices[k].int_map
        name  = d.device_name
      }
    }

  ### Logical Interface Name => ID Lookup Map ###
  logical_int_map = {
    for k,l in var.device.logical_interfaces :
      k => {
        id = module.logical_interfaces[k].logical_int_id
        name = l.interface_name
      }
  }
}

### Load VMware VMM Domains ###
data "aci_vmm_domain" "vmware" {
  count = var.device.domain.type == "vmware" ? 1 : 0

	provider_profile_dn  = "uni/vmmp-VMware"
	name                 = var.device.domain.name
}

### Load Physical Domains ###
data "aci_physical_domain" "physical" {
  count = var.device.domain.type == "physical" ? 1 : 0

  name  = var.device.domain.name
}


### Create new L4-L7 Device ###
resource "aci_l4_l7_device" "device" {

  tenant_dn        = var.tenant.id
  name             = var.device.device_name
  active           = var.device.active
  context_aware    = var.device.context_aware
  device_type      = try(upper(var.device.device_type), null)
  function_type    = var.device.function_type
  is_copy          = var.device.is_copy
  mode             = var.device.mode
  promiscuous_mode = var.device.promiscuous_mode
  service_type     = try(upper(var.device.service_type), null)
  trunking         = var.device.trunking

  ### Physical Type Device ###
  relation_vns_rs_al_dev_to_phys_dom_p = var.device.device_type == "physical" ? data.aci_physical_domain.physical[0].id : null

  # ### Virtual Type Device ###

  dynamic "relation_vns_rs_al_dev_to_dom_p" {
    for_each = local.virtual_domain # var.device.device_type == "virtual" && var.device.domain.type == "vmware" ? 1 : 0
    content {
      domain_dn = relation_vns_rs_al_dev_to_dom_p.value.id
      # switching_mode = "AVE"
    }
  }

}

### ACI L4-L7 Concrete Device Module ###
module "concrete_devices" {
  for_each = var.device.concrete_devices
  source = "./modules/concrete_devices"

  ### VARIABLES ###
  l4_l7_dn        = aci_l4_l7_device.device.id
  domain          = var.device.domain
  concrete_device = each.value
}

### ACI L4-L7 Logical (Cluster) Interface Module ###
module "logical_interfaces" {
  for_each = var.device.logical_interfaces
  source = "./modules/logical_interfaces"

  ### VARIABLES ###
  l4_l7_dn  = aci_l4_l7_device.device.id
  int_map   = local.int_map
  # domain    = var.device.domain
  interface = each.value
}
