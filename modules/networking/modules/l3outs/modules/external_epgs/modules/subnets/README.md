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
| [aci_l3_ext_subnet.extsubnets](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/l3_ext_subnet) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_external_epg_dn"></a> [external\_epg\_dn](#input\_external\_epg\_dn) | n/a | `any` | n/a | yes |
| <a name="input_subnet"></a> [subnet](#input\_subnet) | n/a | <pre>object({<br>    description = string<br>    aggregate   = string<br>    ip          = string<br>    scope       = list(string)<br>  })</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->