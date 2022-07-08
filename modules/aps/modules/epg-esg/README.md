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
| [aci_endpoint_security_group_epg_selector.epg_esg](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/endpoint_security_group_epg_selector) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_epg_map"></a> [epg\_map](#input\_epg\_map) | n/a | `any` | n/a | yes |
| <a name="input_esg_map"></a> [esg\_map](#input\_esg\_map) | n/a | `any` | n/a | yes |
| <a name="input_key"></a> [key](#input\_key) | ### Endpoint Group (EPG) to Endpoint Security Group (ESG) Mapping #### | `any` | n/a | yes |
| <a name="input_mapping"></a> [mapping](#input\_mapping) | n/a | `any` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->