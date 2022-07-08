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
| [aci_epg_to_domain.physical](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/epg_to_domain) | resource |
| [aci_epg_to_domain.vmware](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/epg_to_domain) | resource |
| [aci_physical_domain.physical](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/data-sources/physical_domain) | data source |
| [aci_vmm_domain.vmware](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/data-sources/vmm_domain) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ap_name"></a> [ap\_name](#input\_ap\_name) | n/a | `any` | n/a | yes |
| <a name="input_domain"></a> [domain](#input\_domain) | n/a | <pre>object({<br>    name                  = string<br>    type                  = string<br>    vmm_allow_promiscuous = optional(string)<br>    vmm_forged_transmits  = optional(string)<br>    vmm_mac_changes       = optional(string)<br>    })</pre> | n/a | yes |
| <a name="input_epg_id"></a> [epg\_id](#input\_epg\_id) | n/a | `any` | n/a | yes |
| <a name="input_epg_name"></a> [epg\_name](#input\_epg\_name) | n/a | `any` | n/a | yes |
| <a name="input_tenant_name"></a> [tenant\_name](#input\_tenant\_name) | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dpg_id"></a> [dpg\_id](#output\_dpg\_id) | n/a |
| <a name="output_dpg_name"></a> [dpg\_name](#output\_dpg\_name) | n/a |
<!-- END_TF_DOCS -->