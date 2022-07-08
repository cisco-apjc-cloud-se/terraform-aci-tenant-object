<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aci"></a> [aci](#requirement\_aci) | >=2.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aci"></a> [aci](#provider\_aci) | >=2.0.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_concrete_devices"></a> [concrete\_devices](#module\_concrete\_devices) | ./modules/concrete_devices | n/a |
| <a name="module_logical_interfaces"></a> [logical\_interfaces](#module\_logical\_interfaces) | ./modules/logical_interfaces | n/a |

## Resources

| Name | Type |
|------|------|
| [aci_l4_l7_device.device](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/l4_l7_device) | resource |
| [aci_physical_domain.physical](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/data-sources/physical_domain) | data source |
| [aci_vmm_domain.vmware](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/data-sources/vmm_domain) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_device"></a> [device](#input\_device) | # New Single-Object Tenant Model ## | <pre>object({<br>    device_name      = string<br>    active           = optional(string)<br>    context_aware    = optional(string)<br>    device_type      = optional(string) # Allowed values are "cloud", "physical", "virtual", and default value is "physical" NOTE: Resource needs capitalization<br>    function_type    = optional(string)<br>    is_copy          = optional(string)<br>    mode             = optional(string)<br>    promiscuous_mode = optional(string)<br>    service_type     = optional(string) # Allowed values are "ADC", "COPY", "FW", "NATIVELB", "OTHERS", and default value is "OTHERS NOTE: Resource needs capitalization<br>    trunking         = optional(string)<br>    domain = object({<br>      name = string<br>      type = string<br>    })<br>    concrete_devices = map(object({<br>      device_name         = string<br>      annotation          = optional(string)<br>      name_alias          = optional(string)<br>      vmm_controller_name = optional(string)<br>      vm_name             = optional(string)<br>      interfaces = map(object({<br>        interface_name  = string<br>        encap           = optional(string)<br>        vnic_name       = optional(string)<br>        pod             = optional(number)<br>        node            = optional(number)<br>        port            = optional(string)<br>      }))<br>    }))<br>    logical_interfaces = map(object({<br>      interface_name            = string<br>      annotation                = optional(string)<br>      encap                     = optional(string)<br>      enhanced_lag_policy_name  = optional(string)<br>    }))<br>  })</pre> | n/a | yes |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | n/a | <pre>object({<br>    id    = string<br>    name  = string<br>    })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_device_id"></a> [device\_id](#output\_device\_id) | n/a |
| <a name="output_logical_int_map"></a> [logical\_int\_map](#output\_logical\_int\_map) | n/a |
<!-- END_TF_DOCS -->