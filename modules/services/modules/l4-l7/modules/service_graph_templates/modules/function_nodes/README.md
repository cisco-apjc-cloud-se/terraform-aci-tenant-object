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
| [aci_function_node.node](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/function_node) | resource |
| [aci_l4_l7_device.device](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/data-sources/l4_l7_device) | data source |
| [aci_tenant.tenant](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/data-sources/tenant) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_device_map"></a> [device\_map](#input\_device\_map) | n/a | `any` | n/a | yes |
| <a name="input_node"></a> [node](#input\_node) | # New Single-Object Tenant Model ## | <pre>object({<br>    node_name           = string<br>    annotation          = optional(string)<br>    description         = optional(string)<br>    func_template_type  = string<br>    func_type           = optional(string)<br>    is_copy             = optional(string)<br>    managed             = optional(string)<br>    name_alias          = optional(string)<br>    routing_mode        = string<br>    sequence_number     = number<br>    share_encap         = optional(string)<br>    device              = object({<br>      tenant_name = optional(string)<br>      device_name = string<br>    })<br><br>    # relation_vns_rs_node_to_abs_func_prof - (Optional) Relation to class vnsAbsFuncProf. Cardinality - N_TO_ONE. Type - String.<br>    # relation_vns_rs_node_to_l_dev - (Optional) Relation to class vnsALDevIf. Cardinality - N_TO_ONE. Type - String.<br>    # relation_vns_rs_node_to_m_func - (Optional) Relation to class vnsMFunc. Cardinality - N_TO_ONE. Type - String.<br>    # relation_vns_rs_default_scope_to_term - (Optional) Relation to class vnsATerm. Cardinality - ONE_TO_ONE. Type - String.<br>    # relation_vns_rs_node_to_cloud_l_dev - (Optional) Relation to class cloudALDev. Cardinality - N_TO_ONE. Type - String.<br><br>  })</pre> | n/a | yes |
| <a name="input_template_dn"></a> [template\_dn](#input\_template\_dn) | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_conn_consumer_dn"></a> [conn\_consumer\_dn](#output\_conn\_consumer\_dn) | n/a |
| <a name="output_conn_provider_dn"></a> [conn\_provider\_dn](#output\_conn\_provider\_dn) | n/a |
| <a name="output_node_id"></a> [node\_id](#output\_node\_id) | n/a |
<!-- END_TF_DOCS -->