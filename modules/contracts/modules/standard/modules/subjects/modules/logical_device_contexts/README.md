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
| <a name="module_consumer_interface"></a> [consumer\_interface](#module\_consumer\_interface) | ./modules/logical_interface_contexts | n/a |
| <a name="module_provider_interface"></a> [provider\_interface](#module\_provider\_interface) | ./modules/logical_interface_contexts | n/a |

## Resources

| Name | Type |
|------|------|
| [aci_logical_device_context.node](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/logical_device_context) | resource |
| [aci_l4_l7_device.device](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/data-sources/l4_l7_device) | data source |
| [aci_tenant.tenant](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/data-sources/tenant) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_contract_name"></a> [contract\_name](#input\_contract\_name) | n/a | `any` | n/a | yes |
| <a name="input_device_map"></a> [device\_map](#input\_device\_map) | n/a | `any` | n/a | yes |
| <a name="input_logical_device_context"></a> [logical\_device\_context](#input\_logical\_device\_context) | n/a | <pre>object({<br>    node_name     = string<br>    device = object({<br>      tenant_name = optional(string)<br>      device_name = string<br>    })<br>    annotation    = optional(string)<br>    description   = optional(string)<br>    context       = optional(string)<br>    name_alias    = optional(string)<br>    router_config = optional(string)<br>    consumer_interface = object({<br>      type                = string<br>      conn_name           = string<br>      cluster_interface   = string<br>      l3_dest             = optional(string)<br>      redirect_policy     = optional(string)<br>      service_epg_policy  = optional(string)<br>      annotation          = optional(string)<br>      description         = optional(string)<br>      name_alias          = optional(string)<br>      permit_log          = optional(string)<br>      bd = object({<br>        tenant_name = optional(string)<br>        bd_name     = optional(string)<br>      })<br>      extepg = object({<br>        tenant_name = optional(string)<br>        l3out_name  = optional(string)<br>        extepg_name = optional(string)<br>      })<br>    })<br>    provider_interface = object({<br>      type                = string<br>      conn_name           = string<br>      cluster_interface   = string<br>      l3_dest             = optional(string)<br>      redirect_policy     = optional(string)<br>      service_epg_policy  = optional(string)<br>      annotation          = optional(string)<br>      description         = optional(string)<br>      name_alias          = optional(string)<br>      permit_log          = optional(string)<br>      bd = object({<br>        tenant_name = optional(string)<br>        bd_name     = optional(string)<br>      })<br>      extepg = object({<br>        tenant_name = optional(string)<br>        l3out_name  = optional(string)<br>        extepg_name = optional(string)<br>      })<br>    })<br>  })</pre> | n/a | yes |
| <a name="input_srp_map"></a> [srp\_map](#input\_srp\_map) | n/a | `any` | n/a | yes |
| <a name="input_template_name"></a> [template\_name](#input\_template\_name) | n/a | `any` | n/a | yes |
| <a name="input_tenant_dn"></a> [tenant\_dn](#input\_tenant\_dn) | n/a | `any` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->