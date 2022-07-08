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
| [aci_destination_of_redirected_traffic.destination](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/destination_of_redirected_traffic) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_destination"></a> [destination](#input\_destination) | n/a | <pre>object({<br>    ip            = string<br>    mac           = string<br>    annotation    = optional(string)<br>    description   = optional(string)<br>    dest_name     = optional(string)<br>    ip2           = optional(string) # Default value: "0.0.0.0"<br>    name_alias    = optional(string)<br>    pod_id        = optional(number) # Allowed value range: "1" to "255". Default value: "1"<br>    health_group  = optional(string)<br>    # relation_vns_rs_redirect_health_group - (Optional) Relation to class vns Redirect Health Group. Cardinality - N_TO_ONE. Type - String.<br>    })</pre> | n/a | yes |
| <a name="input_health_group_map"></a> [health\_group\_map](#input\_health\_group\_map) | n/a | `any` | n/a | yes |
| <a name="input_service_redirect_policy_dn"></a> [service\_redirect\_policy\_dn](#input\_service\_redirect\_policy\_dn) | n/a | `any` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->