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
| <a name="module_first_connection"></a> [first\_connection](#module\_first\_connection) | ./modules/connections | n/a |
| <a name="module_function_nodes"></a> [function\_nodes](#module\_function\_nodes) | ./modules/function_nodes | n/a |
| <a name="module_intermediate_connections"></a> [intermediate\_connections](#module\_intermediate\_connections) | ./modules/connections | n/a |
| <a name="module_last_connection"></a> [last\_connection](#module\_last\_connection) | ./modules/connections | n/a |

## Resources

| Name | Type |
|------|------|
| [aci_l4_l7_service_graph_template.template](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/l4_l7_service_graph_template) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_device_map"></a> [device\_map](#input\_device\_map) | n/a | `any` | n/a | yes |
| <a name="input_service_graph_template"></a> [service\_graph\_template](#input\_service\_graph\_template) | # New Single-Object Tenant Model ## | <pre>object({<br>    template_name                     = string<br>    annotation                        = optional(string)<br>    name_alias                        = optional(string)<br>    description                       = optional(string)<br>    l4_l7_service_graph_template_type = optional(string)<br>    ui_template_type                  = string<br>    term_prov_name                    = optional(string)<br>    term_cons_name                    = optional(string)<br>    function_nodes = map(object({<br>      node_name           = string<br>      annotation          = optional(string)<br>      description         = optional(string)<br>      func_template_type  = string<br>      func_type           = optional(string)<br>      is_copy             = optional(string)<br>      managed             = optional(string)<br>      name_alias          = optional(string)<br>      routing_mode        = string<br>      sequence_number     = number<br>      share_encap         = optional(string)<br>      device              = object({<br>        tenant_name = optional(string)<br>        device_name = string<br>      })<br>    }))<br>    # connections = map(object({<br>    #   connection_name = string<br>    #   adj_type        = string<br>    #   description     = optional(string)<br>    #   annotation      = optional(string)<br>    #   conn_dir        = string<br>    #   conn_type       = optional(string)<br>    #   direct_connect  = optional(string)<br>    #   name_alias      = optional(string)<br>    #   unicast_route   = optional(string)<br>    # }))<br>  })</pre> | n/a | yes |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | n/a | <pre>object({<br>    id    = string<br>    name  = string<br>    })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_template_id"></a> [template\_id](#output\_template\_id) | n/a |
<!-- END_TF_DOCS -->