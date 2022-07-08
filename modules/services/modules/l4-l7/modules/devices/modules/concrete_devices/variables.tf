variable "l4_l7_dn" {}

variable "domain" {}

variable "concrete_device" {
  type = object({
    device_name         = string
    annotation          = optional(string)
    name_alias          = optional(string)
    vmm_controller_name = optional(string)
    vm_name             = optional(string)
    interfaces = map(object({
      interface_name  = string
      encap           = optional(string)
      vnic_name       = optional(string)
      pod             = optional(number)
      node            = optional(number)
      port            = optional(string)
    }))
  })
}
