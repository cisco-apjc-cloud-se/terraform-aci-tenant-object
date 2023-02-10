variable "tenant" {
  type = object({
    id    = string
    name  = string
    })
}

## New Single-Object Tenant Model ##
variable "device" {
  type = object({
    device_name      = string
    active           = optional(string)
    context_aware    = optional(string)
    device_type      = optional(string) # Allowed values are "cloud", "physical", "virtual", and default value is "physical" NOTE: Resource needs capitalization
    function_type    = optional(string)
    is_copy          = optional(string)
    mode             = optional(string)
    promiscuous_mode = optional(string)
    service_type     = optional(string) # Allowed values are "ADC", "COPY", "FW", "NATIVELB", "OTHERS", and default value is "OTHERS NOTE: Resource needs capitalization
    trunking         = optional(string)
    domain = object({
      name = string
      type = string
    })
    concrete_devices = map(object({
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
    }))
    logical_interfaces = map(object({
      interface_name            = string
      annotation                = optional(string)
      encap                     = optional(string)
      enhanced_lag_policy_name  = optional(string)
    }))
  })
}
