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
| [aci_l4_l7_logical_interface.int](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/l4_l7_logical_interface) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_int_map"></a> [int\_map](#input\_int\_map) | n/a | `any` | n/a | yes |
| <a name="input_interface"></a> [interface](#input\_interface) | n/a | <pre>object({<br>    interface_name            = string<br>    annotation                = optional(string)<br>    encap                     = optional(string)<br>    enhanced_lag_policy_name  = optional(string)<br>    # concrete_interfaces       = list(string)  # Links by interface_name<br>  })</pre> | n/a | yes |
| <a name="input_l4_l7_dn"></a> [l4\_l7\_dn](#input\_l4\_l7\_dn) | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_logical_int_id"></a> [logical\_int\_id](#output\_logical\_int\_id) | n/a |
<!-- END_TF_DOCS -->