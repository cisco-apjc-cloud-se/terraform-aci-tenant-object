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
| <a name="module_bgp_peers"></a> [bgp\_peers](#module\_bgp\_peers) | ./modules/bgp_peers | n/a |
| <a name="module_interface_profiles"></a> [interface\_profiles](#module\_interface\_profiles) | ./modules/interface_profiles | n/a |
| <a name="module_nodes"></a> [nodes](#module\_nodes) | ./modules/nodes | n/a |

## Resources

| Name | Type |
|------|------|
| [aci_logical_node_profile.lprof](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/logical_node_profile) | resource |
| [aci_logical_node_profile.lprof](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/data-sources/logical_node_profile) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_l3out_dn"></a> [l3out\_dn](#input\_l3out\_dn) | n/a | `any` | n/a | yes |
| <a name="input_logical_node_profile"></a> [logical\_node\_profile](#input\_logical\_node\_profile) | n/a | <pre>object({<br>    lprof_name    = string<br>    use_existing  = optional(bool)<br>    description   = string<br>    bgp_peers = map(object({<br>      peer_ip                         = string<br>      peer_asn                        = number<br>      addr_t_ctrl                     = optional(list(string))<br>      admin_state                     = optional(string)<br>      allowed_self_as_cnt             = optional(number)<br>      description                     = optional(string)<br>      annotation                      = optional(string)<br>      ctrl                            = optional(list(string))<br>      name_alias                      = optional(string)<br>      password                        = optional(string)<br>      peer_ctrl                       = optional(list(string))<br>      private_a_sctrl                 = optional(list(string))<br>      ttl                             = optional(number)<br>      weight                          = optional(number)<br>      local_asn                       = optional(number)<br>      local_asn_propagate             = optional(string)<br>      peer_prefix_policy              = optional(string)<br>      route_control_profiles          = map(object({<br>        direction = optional(string)<br>        target_dn = string<br>      }))<br>    }))<br>    nodes = map(object({<br>      pod         = number<br>      leaf_node   = number<br>      loopback_ip = string<br>    }))<br>    interface_profiles = map(object({<br>      intprof_name = string<br>      description  = string<br>      ospf_profile = object({<br>        enabled     = optional(bool)<br>        description = optional(string)<br>        auth_key    = optional(string)<br>        auth_key_id = optional(number)<br>        auth_type   = optional(string)<br>        ospf_policy = object({<br>          tenant_name = optional(string)<br>          policy_name = optional(string)<br>          })<br>      })<br>      floating_svis = map(object({<br>        pod         = number<br>        node        = number<br>        vlan_id     = number<br>        ip          = string ## Anchor Node IP<br>        description = optional(string)<br>        domains     = map(object({<br>          name              = string<br>          type              = string<br>          floating_ip       = optional(string)<br>          forged_transmit   = optional(string)<br>          mac_change        = optional(string)<br>          promiscuous_mode  = optional(string)<br>          }))<br>        }))<br>      paths = map(object({<br>        description     = string<br>        path_type       = string<br>        ip              = optional(string)<br>        vlan_id         = optional(number)<br>        interface_type  = string<br>        port = object({<br>          pod       = optional(number)<br>          node      = optional(number)<br>          port_name = optional(string)  ## Includes Direct Port Channel<br>        })<br>        vpc = object({<br>          pod         = optional(number)<br>          vpc_name    = optional(string)<br>          side_a = object({<br>            node          = optional(number)<br>            ip            = optional(string)<br>            annotation    = optional(string)<br>            ipv6_dad      = optional(string)<br>            ll_addr       = optional(string)<br>            description   = optional(string)<br>            name_alias    = optional(string)<br>          })<br>          side_b = object({<br>            node          = optional(number)<br>            ip            = optional(string)<br>            annotation    = optional(string)<br>            ipv6_dad      = optional(string)<br>            ll_addr       = optional(string)<br>            description   = optional(string)<br>            name_alias    = optional(string)<br>          })<br>        })<br>        annotation  = optional(string)<br>        autostate   = optional(string)<br>        encap_scope = optional(string)<br>        ipv6_dad    = optional(string)<br>        ll_addr     = optional(string)<br>        mac         = optional(string)<br>        mode        = optional(string)<br>        mtu         = optional(string)<br>        target_dscp = optional(string)<br>      }))<br>    }))<br>  })</pre> | n/a | yes |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | n/a | <pre>object({<br>    id    = string<br>    name  = string<br>    })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_lprof_id"></a> [lprof\_id](#output\_lprof\_id) | n/a |
<!-- END_TF_DOCS -->