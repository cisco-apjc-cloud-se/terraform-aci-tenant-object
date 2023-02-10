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
| [aci_epg_to_static_path.path](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/epg_to_static_path) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_epg_id"></a> [epg\_id](#input\_epg\_id) | n/a | `any` | n/a | yes |
| <a name="input_path"></a> [path](#input\_path) | n/a | <pre>object({<br>    pod       = number<br>    leaf_node = number<br>    port      = string<br>    vlan_id   = number<br>    mode      = string<br>    })</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->