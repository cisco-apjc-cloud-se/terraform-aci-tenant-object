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
| [aci_logical_interface_context.interface](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/logical_interface_context) | resource |
| [aci_bridge_domain.external_bd](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/data-sources/bridge_domain) | data source |
| [aci_external_network_instance_profile.extepg](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/data-sources/external_network_instance_profile) | data source |
| [aci_l3_outside.external_l3_out](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/data-sources/l3_outside) | data source |
| [aci_tenant.external_bd_tenant](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/data-sources/tenant) | data source |
| [aci_tenant.external_extepg_tenant](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/data-sources/tenant) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_interface"></a> [interface](#input\_interface) | n/a | <pre>object({<br>    type                = string  # "general" or "route_peering"<br>    conn_name           = string<br>    cluster_interface   = string<br>    l3_dest             = optional(string)<br>    redirect_policy     = optional(string)<br>    service_epg_policy  = optional(string)<br>    annotation          = optional(string)<br>    description         = optional(string)<br>    name_alias          = optional(string)<br>    permit_log          = optional(string)<br>    bd = object({<br>      tenant_name = optional(string)<br>      bd_name     = optional(string)<br>    })<br>    extepg = object({<br>      tenant_name = optional(string)<br>      l3out_name  = optional(string)<br>      extepg_name = optional(string)<br>    })<br>  })</pre> | n/a | yes |
| <a name="input_logical_device_context_dn"></a> [logical\_device\_context\_dn](#input\_logical\_device\_context\_dn) | n/a | `any` | n/a | yes |
| <a name="input_logical_int_map"></a> [logical\_int\_map](#input\_logical\_int\_map) | n/a | `any` | n/a | yes |
| <a name="input_srp_map"></a> [srp\_map](#input\_srp\_map) | n/a | `any` | n/a | yes |
| <a name="input_tenant_dn"></a> [tenant\_dn](#input\_tenant\_dn) | n/a | `any` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->