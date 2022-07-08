<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aci"></a> [aci](#requirement\_aci) | >=2.0.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_l4-l7"></a> [l4-l7](#module\_l4-l7) | ./modules/l4-l7 | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_services"></a> [services](#input\_services) | # New Single-Object Tenant Model ## | <pre>object({<br>    l4-l7 = object({<br>      devices = map(object({<br>        device_name      = string<br>        active           = optional(string)<br>        context_aware    = optional(string)<br>        device_type      = optional(string) # Allowed values are "cloud", "physical", "virtual", and default value is "physical" NOTE: Resource needs capitalization<br>        function_type    = optional(string)<br>        is_copy          = optional(string)<br>        mode             = optional(string)<br>        promiscuous_mode = optional(string)<br>        service_type     = optional(string) # Allowed values are "ADC", "COPY", "FW", "NATIVELB", "OTHERS", and default value is "OTHERS NOTE: Resource needs capitalization<br>        trunking         = optional(string)<br>        domain = object({<br>          name = string<br>          type = string<br>        })<br>        concrete_devices = map(object({<br>          device_name         = string<br>          annotation          = optional(string)<br>          name_alias          = optional(string)<br>          vmm_controller_name = optional(string)<br>          vm_name             = optional(string)<br>          interfaces = map(object({<br>            interface_name  = string<br>            encap           = optional(string)<br>            vnic_name       = optional(string)<br>            pod             = optional(number)<br>            node            = optional(number)<br>            port            = optional(string)<br>          }))<br>        }))<br>        logical_interfaces = map(object({<br>          interface_name            = string<br>          annotation                = optional(string)<br>          encap                     = optional(string)<br>          enhanced_lag_policy_name  = optional(string)<br>        }))<br>      }))<br>      service_graph_templates = map(object({<br>        template_name                     = string<br>        annotation                        = optional(string)<br>        name_alias                        = optional(string)<br>        description                       = optional(string)<br>        l4_l7_service_graph_template_type = optional(string)<br>        ui_template_type                  = string<br>        term_prov_name                    = optional(string)<br>        term_cons_name                    = optional(string)<br>        function_nodes = map(object({<br>          node_name           = string<br>          annotation          = optional(string)<br>          description         = optional(string)<br>          func_template_type  = string<br>          func_type           = optional(string)<br>          is_copy             = optional(string)<br>          managed             = optional(string)<br>          name_alias          = optional(string)<br>          routing_mode        = string<br>          sequence_number     = number<br>          share_encap         = optional(string)<br>          device              = object({<br>            tenant_name = optional(string)<br>            device_name = string<br>          })<br>        }))<br>      }))<br>    })<br>  })</pre> | n/a | yes |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | n/a | <pre>object({<br>    id    = string<br>    name  = string<br>    })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_device_map"></a> [device\_map](#output\_device\_map) | n/a |
| <a name="output_sgt_map"></a> [sgt\_map](#output\_sgt\_map) | n/a |
<!-- END_TF_DOCS -->