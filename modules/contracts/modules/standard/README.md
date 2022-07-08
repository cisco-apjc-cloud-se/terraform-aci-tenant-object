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
| <a name="module_subjects"></a> [subjects](#module\_subjects) | ./modules/subjects | n/a |

## Resources

| Name | Type |
|------|------|
| [aci_contract.contract](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/contract) | resource |
| [aci_contract.contract](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/data-sources/contract) | data source |
| [aci_tenant.tenant](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/data-sources/tenant) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_contract"></a> [contract](#input\_contract) | ## Contracts Input Variable Object ### | <pre>object({<br>    contract_name = string<br>    tenant_name   = optional(string)<br>    use_existing  = optional(bool)<br>    description   = optional(string)<br>    scope         = optional(string)<br>    subjects = map(object({<br>      subject_name  = string<br>      description   = optional(string)<br>      filters       = map(object({<br>        filter_name = string<br>        tenant_name = optional(string)<br>      }))<br>      service_graph = object({<br>        tenant_name = optional(string)<br>        template_name = optional(string)<br>        nodes = map(object({<br>          node_name     = string<br>          device = object({<br>            tenant_name = optional(string)<br>            device_name = string<br>          })<br>          annotation    = optional(string)<br>          description   = optional(string)<br>          context       = optional(string)<br>          name_alias    = optional(string)<br>          router_config = optional(string)<br>          consumer_interface = object({<br>            type                = string<br>            conn_name           = string<br>            cluster_interface   = string<br>            l3_dest             = optional(string)<br>            redirect_policy     = optional(string)<br>            service_epg_policy  = optional(string)<br>            annotation          = optional(string)<br>            description         = optional(string)<br>            name_alias          = optional(string)<br>            permit_log          = optional(string)<br>            bd = object({<br>              tenant_name = optional(string)<br>              bd_name     = optional(string)<br>            })<br>            extepg = object({<br>              tenant_name = optional(string)<br>              l3out_name  = optional(string)<br>              extepg_name = optional(string)<br>            })<br>          })<br>          provider_interface = object({<br>            type                = string<br>            conn_name           = string<br>            cluster_interface   = string<br>            l3_dest             = optional(string)<br>            redirect_policy     = optional(string)<br>            service_epg_policy  = optional(string)<br>            annotation          = optional(string)<br>            description         = optional(string)<br>            name_alias          = optional(string)<br>            permit_log          = optional(string)<br>            bd = object({<br>              tenant_name = optional(string)<br>              bd_name     = optional(string)<br>            })<br>            extepg = object({<br>              tenant_name = optional(string)<br>              l3out_name  = optional(string)<br>              extepg_name = optional(string)<br>            })<br>          })<br>        }))<br>      })<br>    }))<br>  })</pre> | n/a | yes |
| <a name="input_device_map"></a> [device\_map](#input\_device\_map) | n/a | `any` | n/a | yes |
| <a name="input_filter_map"></a> [filter\_map](#input\_filter\_map) | n/a | `any` | n/a | yes |
| <a name="input_sgt_map"></a> [sgt\_map](#input\_sgt\_map) | n/a | `any` | n/a | yes |
| <a name="input_srp_map"></a> [srp\_map](#input\_srp\_map) | n/a | `any` | n/a | yes |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | n/a | <pre>object({<br>    id    = string<br>    name  = string<br>    })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_contract_id"></a> [contract\_id](#output\_contract\_id) | n/a |
<!-- END_TF_DOCS -->