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
| [aci_any.vzany](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/any) | resource |
| [aci_vrf.vrf](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/vrf) | resource |
| [aci_vrf.vrf](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/data-sources/vrf) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_tenant"></a> [tenant](#input\_tenant) | n/a | <pre>object({<br>    id    = string<br>    name  = string<br>    })</pre> | n/a | yes |
| <a name="input_vrf"></a> [vrf](#input\_vrf) | n/a | <pre>object({<br>    vrf_name        = string<br>    use_existing    = optional(bool)<br>    description     = string<br>    preferred_group = string<br>    })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vrf_id"></a> [vrf\_id](#output\_vrf\_id) | n/a |
<!-- END_TF_DOCS -->