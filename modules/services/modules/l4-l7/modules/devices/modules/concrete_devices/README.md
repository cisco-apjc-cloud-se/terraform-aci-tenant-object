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
| <a name="module_concrete_interfaces"></a> [concrete\_interfaces](#module\_concrete\_interfaces) | ./modules/concrete_interfaces | n/a |

## Resources

| Name | Type |
|------|------|
| [aci_concrete_device.device](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/concrete_device) | resource |
| [aci_vmm_controller.vmware](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/data-sources/vmm_controller) | data source |
| [aci_vmm_domain.vmware](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/data-sources/vmm_domain) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_concrete_device"></a> [concrete\_device](#input\_concrete\_device) | n/a | <pre>object({<br>    device_name         = string<br>    annotation          = optional(string)<br>    name_alias          = optional(string)<br>    vmm_controller_name = optional(string)<br>    vm_name             = optional(string)<br>    interfaces = map(object({<br>      interface_name  = string<br>      encap           = optional(string)<br>      vnic_name       = optional(string)<br>      pod             = optional(number)<br>      node            = optional(number)<br>      port            = optional(string)<br>    }))<br>  })</pre> | n/a | yes |
| <a name="input_domain"></a> [domain](#input\_domain) | n/a | `any` | n/a | yes |
| <a name="input_l4_l7_dn"></a> [l4\_l7\_dn](#input\_l4\_l7\_dn) | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_int_map"></a> [int\_map](#output\_int\_map) | n/a |
<!-- END_TF_DOCS -->