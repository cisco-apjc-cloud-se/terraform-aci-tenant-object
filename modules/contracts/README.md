<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aci"></a> [aci](#requirement\_aci) | >=2.0.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_filters"></a> [filters](#module\_filters) | ./modules/filters | n/a |
| <a name="module_standard"></a> [standard](#module\_standard) | ./modules/standard | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_contracts"></a> [contracts](#input\_contracts) | n/a | <pre>object({<br>    #### Standard Contracts ###<br>    standard = map(object({<br>      contract_name = string<br>      tenant_name   = optional(string)<br>      use_existing  = optional(bool)<br>      description   = optional(string)<br>      scope         = optional(string)<br>      subjects = map(object({<br>        subject_name  = string<br>        description   = optional(string)<br>        filters       = map(object({<br>          filter_name = string<br>          tenant_name = optional(string)<br>        }))<br>        service_graph = object({<br>          tenant_name = optional(string)<br>          template_name = optional(string)<br>          nodes = map(object({<br>            node_name     = string<br>            device = object({<br>              tenant_name = optional(string)<br>              device_name = string<br>            })<br>            annotation    = optional(string)<br>            description   = optional(string)<br>            context       = optional(string)<br>            name_alias    = optional(string)<br>            router_config = optional(string)<br>            consumer_interface = object({<br>              type                = string<br>              conn_name           = string<br>              cluster_interface   = string<br>              l3_dest             = optional(string)<br>              redirect_policy     = optional(string)<br>              service_epg_policy  = optional(string)<br>              annotation          = optional(string)<br>              description         = optional(string)<br>              name_alias          = optional(string)<br>              permit_log          = optional(string)<br>              bd = object({<br>                tenant_name = optional(string)<br>                bd_name     = optional(string)<br>              })<br>              extepg = object({<br>                tenant_name = optional(string)<br>                l3out_name  = optional(string)<br>                extepg_name = optional(string)<br>              })<br>            })<br>            provider_interface = object({<br>              type                = string<br>              conn_name           = string<br>              cluster_interface   = string<br>              l3_dest             = optional(string)<br>              redirect_policy     = optional(string)<br>              service_epg_policy  = optional(string)<br>              annotation          = optional(string)<br>              description         = optional(string)<br>              name_alias          = optional(string)<br>              permit_log          = optional(string)<br>              bd = object({<br>                tenant_name = optional(string)<br>                bd_name     = optional(string)<br>              })<br>              extepg = object({<br>                tenant_name = optional(string)<br>                l3out_name  = optional(string)<br>                extepg_name = optional(string)<br>              })<br>            })<br>          }))<br>        })<br>      }))<br>    }))<br>    #### Filters ####<br>    filters = map(object({<br>      filter_name   = string<br>      use_existing  = optional(bool)<br>      tenant_name   = optional(string)<br>      description   = string<br>      entries = map(object({<br>        name        = string<br>        description = string<br>        ether_t     = string<br>        d_from_port = string<br>        d_to_port   = string<br>        prot        = string<br>        s_from_port = string<br>        s_to_port   = string<br>        }))<br>    }))<br>  })</pre> | n/a | yes |
| <a name="input_device_map"></a> [device\_map](#input\_device\_map) | n/a | `any` | n/a | yes |
| <a name="input_sgt_map"></a> [sgt\_map](#input\_sgt\_map) | n/a | `any` | n/a | yes |
| <a name="input_srp_map"></a> [srp\_map](#input\_srp\_map) | n/a | `any` | n/a | yes |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | ## Tenant Details ### | <pre>object({<br>    id    = string<br>    name  = string<br>    })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_contract_map"></a> [contract\_map](#output\_contract\_map) | n/a |
<!-- END_TF_DOCS -->