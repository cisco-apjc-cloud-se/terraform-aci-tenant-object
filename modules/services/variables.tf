variable "tenant" {
  type = object({
    id    = string
    name  = string
    })
}

## New Single-Object Tenant Model ##
variable "services" {
  type = object({
    l4-l7 = object({
      devices = map(object({
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
      }))
      service_graph_templates = map(object({
        template_name                     = string
        annotation                        = optional(string)
        name_alias                        = optional(string)
        description                       = optional(string)
        l4_l7_service_graph_template_type = optional(string)
        ui_template_type                  = string
        term_prov_name                    = optional(string)
        term_cons_name                    = optional(string)
        function_nodes = map(object({
          node_name           = string
          annotation          = optional(string)
          description         = optional(string)
          func_template_type  = string
          func_type           = optional(string)
          is_copy             = optional(string)
          managed             = optional(string)
          name_alias          = optional(string)
          routing_mode        = string
          sequence_number     = number
          share_encap         = optional(string)
          device              = object({
            tenant_name = optional(string)
            device_name = string
          })
        }))
      }))
    })
  })
}
