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
| <a name="module_domains"></a> [domains](#module\_domains) | ./modules/domains | n/a |
| <a name="module_static_paths"></a> [static\_paths](#module\_static\_paths) | ./modules/static_paths | n/a |

## Resources

| Name | Type |
|------|------|
| [aci_application_epg.epg](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/application_epg) | resource |
| [aci_application_epg.epg](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/data-sources/application_epg) | data source |
| [aci_bridge_domain.bd](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/data-sources/bridge_domain) | data source |
| [aci_tenant.tenant](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/data-sources/tenant) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ap"></a> [ap](#input\_ap) | n/a | `any` | n/a | yes |
| <a name="input_bd_map"></a> [bd\_map](#input\_bd\_map) | n/a | `any` | n/a | yes |
| <a name="input_epg"></a> [epg](#input\_epg) | n/a | <pre>object({<br>    epg_name      = string<br>    use_existing  = optional(bool)<br>    bd = object({<br>      tenant_name = optional(string)<br>      bd_name = string<br>    })<br>    description = string<br>    domains = map(object({<br>      name = string<br>      type = string<br>      vmm_allow_promiscuous = optional(string)<br>      vmm_forged_transmits  = optional(string)<br>      vmm_mac_changes       = optional(string)<br>      }))<br>    mapped_esg = object({<br>      esg_name    = optional(string)<br>      })<br>    preferred_group = optional(string)<br>    paths = map(object({<br>      pod       = number<br>      leaf_node = number<br>      port      = string<br>      vlan_id   = number<br>      mode      = string<br>      }))<br>    })</pre> | n/a | yes |
| <a name="input_key"></a> [key](#input\_key) | ### Endpoint Groups (EPG) #### | `any` | n/a | yes |
| <a name="input_tenant_dn"></a> [tenant\_dn](#input\_tenant\_dn) | n/a | `any` | n/a | yes |
| <a name="input_tenant_name"></a> [tenant\_name](#input\_tenant\_name) | # For VMware DPG Name ### | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dpg_map"></a> [dpg\_map](#output\_dpg\_map) | n/a |
| <a name="output_epg_id"></a> [epg\_id](#output\_epg\_id) | n/a |
<!-- END_TF_DOCS -->