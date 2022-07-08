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

No modules.

## Resources

| Name | Type |
|------|------|
| [aci_concrete_interface.int](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/concrete_interface) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_concrete_dn"></a> [concrete\_dn](#input\_concrete\_dn) | n/a | `any` | n/a | yes |
| <a name="input_domain"></a> [domain](#input\_domain) | n/a | `any` | n/a | yes |
| <a name="input_interface"></a> [interface](#input\_interface) | n/a | <pre>object({<br>    interface_name  = string<br>    encap           = optional(string)<br>    vnic_name       = optional(string)<br>    pod             = optional(number)<br>    node            = optional(number)<br>    port            = optional(string)<br>    })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_interface_id"></a> [interface\_id](#output\_interface\_id) | n/a |
<!-- END_TF_DOCS -->