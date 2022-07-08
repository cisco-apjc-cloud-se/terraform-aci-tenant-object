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
| <a name="module_destinations"></a> [destinations](#module\_destinations) | ./modules/destinations | n/a |

## Resources

| Name | Type |
|------|------|
| [aci_service_redirect_policy.policy](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/service_redirect_policy) | resource |
| [aci_service_redirect_policy.policy](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/data-sources/service_redirect_policy) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_service_redirect_policy"></a> [service\_redirect\_policy](#input\_service\_redirect\_policy) | n/a | <pre>object({<br>    policy_name             = string<br>    name_alias              = optional(string)<br>    use_existing            = optional(bool)<br>    description             = optional(string)<br>    dest_type               = optional(string) # "L1", "L2", "L3". Default value: "L3".<br>    min_threshold_percent   = optional(number) # 0<br>    max_threshold_percent   = optional(number) # 0<br>    hashing_algorithm       = optional(string) # "sip", "dip", "sip-dip-prototype", Default value: "sip-dip-prototype".<br>    ## NOTE: anycast_enabled and program_local_pod_only cannot be "yes" simultaneously.<br>    anycast_enabled         = optional(string) # Allowed values: "yes", "no". Default value: "no".<br>    program_local_pod_only  = optional(string) # Allowed values: "yes", "no". Default value: "no".<br>    resilient_hash_enabled  = optional(string) # Allowed values: "yes", "no". Default value: "no".<br>    threshold_enable        = optional(string) # Allowed values: "yes", "no". Default value: "no".<br>    threshold_down_action   = optional(string) # Allowed values: "bypass", "deny", "permit". Default value: "permit".<br>    ipsla_policy            = optional(string) # relation_vns_rs_ipsla_monitoring_pol<br>    destinations = map(object({<br>      ip            = string<br>      mac           = string<br>      annotation    = optional(string)<br>      description   = optional(string)<br>      dest_name     = optional(string)<br>      ip2           = optional(string)<br>      name_alias    = optional(string)<br>      pod_id        = optional(number)<br>      health_group  = optional(string)<br>    }))<br>  })</pre> | n/a | yes |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | n/a | <pre>object({<br>    id    = string<br>    name  = string<br>    })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_policy_id"></a> [policy\_id](#output\_policy\_id) | n/a |
<!-- END_TF_DOCS -->