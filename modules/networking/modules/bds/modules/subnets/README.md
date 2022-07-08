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
| [aci_subnet.subnet](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/subnet) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_parent_dn"></a> [parent\_dn](#input\_parent\_dn) | n/a | `string` | n/a | yes |
| <a name="input_subnet"></a> [subnet](#input\_subnet) | ## Bridge Domain ### | <pre>object({<br>    description   = string<br>    ip            = string<br>    scope         = list(string)<br>    preferred     = string<br>    })</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->