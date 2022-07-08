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
| [aci_connection.connection](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/connection) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_connection"></a> [connection](#input\_connection) | # New Single-Object Tenant Model ## | <pre>object({<br>    connection_name = string<br>    adj_type        = string # Allowed values are "L2", "L3". Default value is "L2".<br>    description     = optional(string)<br>    annotation      = optional(string)<br>    conn_dir        = string # Allowed values are "consumer", "provider". Default value is "provider".<br>    conn_type       = optional(string) # Allowed values are "external", "internal". Default value is "external".<br>    direct_connect  = optional(string) # Allowed values are "yes" and "no". Default value is "no".<br>    name_alias      = optional(string)<br>    unicast_route   = optional(string) # Unicast route setting should be true for L3 connections. Allowed values are "yes" and "no". Default value is "yes".<br>    dn_list         = list(string)<br>  })</pre> | n/a | yes |
| <a name="input_template_dn"></a> [template\_dn](#input\_template\_dn) | n/a | `any` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->