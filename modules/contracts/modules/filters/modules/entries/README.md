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
| [aci_filter_entry.entry](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/filter_entry) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_entry"></a> [entry](#input\_entry) | n/a | <pre>object({<br>    name        = string<br>    description = string<br>    ether_t     = string<br>    d_from_port = string<br>    d_to_port   = string<br>    prot        = string<br>    s_from_port = string<br>    s_to_port   = string<br>    })</pre> | n/a | yes |
| <a name="input_filter_dn"></a> [filter\_dn](#input\_filter\_dn) | n/a | `any` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->