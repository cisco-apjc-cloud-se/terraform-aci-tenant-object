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
  ### Interface Name => ID Lookup Map ###
  int_map = {
    for k,i in var.concrete_device.interfaces:
      k => {
        id    = module.concrete_interfaces[k].interface_id
        name  = i.interface_name
      }
    }
}

### Load VMware VMM Domains ###
data "aci_vmm_domain" "vmware" {
  count = var.domain.type == "vmware" ? 1 : 0

	provider_profile_dn  = "uni/vmmp-VMware"
	name                 = var.domain.name
}

### Load VMware VMM Domain Controller ###
data "aci_vmm_controller" "vmware" {
  count = var.domain.type == "vmware" ? 1 : 0
  vmm_domain_dn = data.aci_vmm_domain.vmware[0].id
  name          = var.concrete_device.vmm_controller_name
}

### Create new Concrete device ###
resource "aci_concrete_device" "device" {
  l4_l7_device_dn   = var.l4_l7_dn
  name              = var.concrete_device.device_name
  annotation        = var.concrete_device.annotation
  name_alias        = var.concrete_device.name_alias
  vmm_controller_dn = var.domain.type == "vmware" ? data.aci_vmm_controller.vmware[0].id : null  #"uni/vmmp-VMware/dom-ACI-vDS/ctrlr-vcenter"
  vm_name           = var.domain.type == "vmware" ? var.concrete_device.vm_name : null # "tenant1-ASA1"
}

### ACI Concrete Device Interfaces Module ###
module "concrete_interfaces" {
  for_each = var.concrete_device.interfaces
  source = "./modules/concrete_interfaces"

  ### VARIABLES ###
  interface   = each.value
  domain      = var.domain
  concrete_dn = aci_concrete_device.device.id
}

# ### Locals ###
# locals {
#   virtual_domain = var.device.domain.type == "vmware" ? {
#     dom-1 = {
#       name  = var.device.domain.name
#       id    = data.aci_vmm_domain.vmware[0].id
#     }
#   } : null
# }

# ### Load VMware VMM Domains ###
# data "aci_vmm_domain" "vmware" {
#   count = var.device.domain.type == "vmware" ? 1 : 0
#
# 	provider_profile_dn  = "uni/vmmp-VMware"
# 	name                 = var.device.domain.name
# }
#
# ### Load Physical Domains ###
# data "aci_physical_domain" "physical" {
#   count = var.device.domain.type == "physical" ? 1 : 0
#
#   name  = var.device.domain.name
# }
#
# resource "aci_l4_l7_device" "device" {
#
#   tenant_dn        = var.tenant.id
#   name             = var.device.device_name
#   active           = var.device.active
#   context_aware    = var.device.context_aware
#   device_type      = try(upper(var.device.device_type), null)
#   function_type    = var.device.function_type
#   is_copy          = var.device.is_copy
#   mode             = var.device.mode
#   promiscuous_mode = var.device.promiscuous_mode
#   service_type     = try(upper(var.device.service_type), null)
#   trunking         = var.device.trunking
#
#   ### Physical Type Device ###
#   relation_vns_rs_al_dev_to_phys_dom_p = var.device.device_type == "physical" ? data.aci_physical_domain.physical[0].id : null
#
#   # ### Virtual Type Device ###
#
#   dynamic "relation_vns_rs_al_dev_to_dom_p" {
#     for_each = local.virtual_domain # var.device.device_type == "virtual" && var.device.domain.type == "vmware" ? 1 : 0
#     content {
#       domain_dn = relation_vns_rs_al_dev_to_dom_p.value.id
#       # switching_mode = "AVE"
#     }
#   }
#
# }
