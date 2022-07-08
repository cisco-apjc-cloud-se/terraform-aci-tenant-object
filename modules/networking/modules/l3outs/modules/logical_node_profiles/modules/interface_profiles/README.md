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
| <a name="module_floating_svis"></a> [floating\_svis](#module\_floating\_svis) | ./modules/floating_svis | n/a |
| <a name="module_paths"></a> [paths](#module\_paths) | ./modules/paths | n/a |

## Resources

| Name | Type |
|------|------|
| [aci_l3out_ospf_interface_profile.ospf](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/l3out_ospf_interface_profile) | resource |
| [aci_logical_interface_profile.intprof](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/logical_interface_profile) | resource |
| [aci_logical_interface_profile.intprof](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/data-sources/logical_interface_profile) | data source |
| [aci_ospf_interface_policy.ospf](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/data-sources/ospf_interface_policy) | data source |
| [aci_tenant.tenant](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/data-sources/tenant) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_interface_profile"></a> [interface\_profile](#input\_interface\_profile) | n/a | <pre>object({<br>    intprof_name = string<br>    use_existing = optional(bool)<br>    description  = string<br>    ospf_profile = object({<br>      enabled     = optional(bool)<br>      description = optional(string)<br>      auth_key    = optional(string)<br>      auth_key_id = optional(number)<br>      auth_type   = optional(string)<br>      ospf_policy = object({<br>        tenant_name = optional(string)<br>        policy_name = optional(string)<br>        })<br>    })<br>    floating_svis = map(object({<br>      pod         = number<br>      node        = number<br>      vlan_id     = number<br>      ip          = string<br>      description = optional(string)<br>      domains     = map(object({<br>        name              = string<br>        type              = string<br>        floating_ip       = optional(string)<br>        forged_transmit   = optional(string)<br>        mac_change        = optional(string)<br>        promiscuous_mode  = optional(string)<br>        }))<br>      }))<br>    paths = map(object({<br>      description     = string<br>      path_type       = string<br>      ip              = optional(string)<br>      vlan_id         = optional(number)<br>      interface_type  = string<br>      port = object({<br>        pod       = optional(number)<br>        node      = optional(number)<br>        port_name = optional(string)  ## Includes Direct Port Channel<br>      })<br>      vpc = object({<br>        pod         = optional(number)<br>        vpc_name    = optional(string)<br>        side_a = object({<br>          node          = optional(number)<br>          ip            = optional(string)<br>          annotation    = optional(string)<br>          ipv6_dad      = optional(string)<br>          ll_addr       = optional(string)<br>          description   = optional(string)<br>          name_alias    = optional(string)<br>        })<br>        side_b = object({<br>          node          = optional(number)<br>          ip            = optional(string)<br>          annotation    = optional(string)<br>          ipv6_dad      = optional(string)<br>          ll_addr       = optional(string)<br>          description   = optional(string)<br>          name_alias    = optional(string)<br>        })<br>      })<br>      annotation  = optional(string)<br>      autostate   = optional(string)<br>      encap_scope = optional(string)<br>      ipv6_dad    = optional(string)<br>      ll_addr     = optional(string)<br>      mac         = optional(string)<br>      mode        = optional(string)<br>      mtu         = optional(string)<br>      target_dscp = optional(string)<br>    }))<br>  })</pre> | n/a | yes |
| <a name="input_lprof_dn"></a> [lprof\_dn](#input\_lprof\_dn) | n/a | `any` | n/a | yes |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | n/a | <pre>object({<br>    id    = string<br>    name  = string<br>    })</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->