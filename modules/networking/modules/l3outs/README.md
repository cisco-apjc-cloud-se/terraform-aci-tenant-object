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
| <a name="module_external_epgs"></a> [external\_epgs](#module\_external\_epgs) | ./modules/external_epgs | n/a |
| <a name="module_logical_node_profiles"></a> [logical\_node\_profiles](#module\_logical\_node\_profiles) | ./modules/logical_node_profiles | n/a |

## Resources

| Name | Type |
|------|------|
| [aci_l3_outside.l3out](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/l3_outside) | resource |
| [aci_l3out_ospf_external_policy.ospf](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/l3out_ospf_external_policy) | resource |
| [aci_l3_domain_profile.l3domain](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/data-sources/l3_domain_profile) | data source |
| [aci_l3_outside.l3out](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/data-sources/l3_outside) | data source |
| [aci_tenant.tenant](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/data-sources/tenant) | data source |
| [aci_vrf.vrf](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/data-sources/vrf) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_contract_map"></a> [contract\_map](#input\_contract\_map) | ## Contract Map ### | `any` | n/a | yes |
| <a name="input_l3out"></a> [l3out](#input\_l3out) | ## L3Out Input Variable Object ### | <pre>object({<br>    l3out_name    = string<br>    use_existing      = optional(bool)<br>    description   = string<br>    vrf = object({<br>      tenant_name = optional(string)<br>      vrf_name    = string<br>      })<br>    l3_domain     = string<br>    ospf_policy = object({<br>      enabled     = optional(bool)<br>      ## Too many optional?  Should be optional object?<br>      description = optional(string)<br>      area_cost   = optional(number)<br>      area_id     = optional(string)<br>      area_type   = optional(string)<br>      })<br>    logical_node_profiles = map(object({<br>      lprof_name    = string<br>      use_existing  = optional(bool)<br>      description   = string<br>      bgp_peers = map(object({<br>        peer_ip                         = string<br>        peer_asn                        = number<br>        addr_t_ctrl                     = optional(list(string))<br>        admin_state                     = optional(string)<br>        allowed_self_as_cnt             = optional(number)<br>        description                     = optional(string)<br>        annotation                      = optional(string)<br>        ctrl                            = optional(list(string))<br>        name_alias                      = optional(string)<br>        password                        = optional(string)<br>        peer_ctrl                       = optional(list(string))<br>        private_a_sctrl                 = optional(list(string))<br>        ttl                             = optional(number)<br>        weight                          = optional(number)<br>        local_asn                       = optional(number)<br>        local_asn_propagate             = optional(string)<br>        peer_prefix_policy              = optional(string)<br>        route_control_profiles          = map(object({<br>          direction = optional(string)<br>          target_dn = string<br>        }))<br>      }))<br>      nodes = map(object({<br>        pod         = number<br>        leaf_node   = number<br>        loopback_ip = string<br>      }))<br>      interface_profiles = map(object({<br>        intprof_name = string<br>        description  = string<br>        ospf_profile = object({<br>          enabled     = optional(bool)<br>          description = optional(string)<br>          auth_key    = optional(string)<br>          auth_key_id = optional(number)<br>          auth_type   = optional(string)<br>          ospf_policy = object({<br>            tenant_name = optional(string)<br>            policy_name = optional(string)<br>            })<br>        })<br>        floating_svis = map(object({<br>          pod         = number<br>          node        = number<br>          vlan_id     = number<br>          ip          = string ## Anchor Node IP<br>          description = optional(string)<br>          domains     = map(object({<br>            name              = string<br>            type              = string<br>            floating_ip       = optional(string)<br>            forged_transmit   = optional(string)<br>            mac_change        = optional(string)<br>            promiscuous_mode  = optional(string)<br>            }))<br>          }))<br>        paths = map(object({<br>          description     = string<br>          path_type       = string<br>          ip              = optional(string)<br>          vlan_id         = optional(number)<br>          interface_type  = string<br>          port = object({<br>            pod       = optional(number)<br>            node      = optional(number)<br>            port_name = optional(string)  ## Includes Direct Port Channel<br>          })<br>          vpc = object({<br>            pod         = optional(number)<br>            vpc_name    = optional(string)<br>            side_a = object({<br>              node          = optional(number)<br>              ip            = optional(string)<br>              annotation    = optional(string)<br>              ipv6_dad      = optional(string)<br>              ll_addr       = optional(string)<br>              description   = optional(string)<br>              name_alias    = optional(string)<br>            })<br>            side_b = object({<br>              node          = optional(number)<br>              ip            = optional(string)<br>              annotation    = optional(string)<br>              ipv6_dad      = optional(string)<br>              ll_addr       = optional(string)<br>              description   = optional(string)<br>              name_alias    = optional(string)<br>            })<br>          })<br>          annotation  = optional(string)<br>          autostate   = optional(string)<br>          encap_scope = optional(string)<br>          ipv6_dad    = optional(string)<br>          ll_addr     = optional(string)<br>          mac         = optional(string)<br>          mode        = optional(string)<br>          mtu         = optional(string)<br>          target_dscp = optional(string)<br>        }))<br>      }))<br>    }))<br>    ## NOTE: Only NEW (managed) ExtEPGs supported - can't change contracts on existing ExtEPGs<br>    external_epgs = map(object({<br>      extepg_name     = string<br>      use_existing    = optional(bool)<br>      description     = string<br>      preferred_group = string<br>      consumed_contracts = map(object({<br>        tenant_name   = optional(string)<br>        contract_name = string<br>      }))<br>      provided_contracts = map(object({<br>        tenant_name   = optional(string)<br>        contract_name = string<br>      }))<br>      contract_master_epgs = map(object({<br>        l3out_name = string<br>        extepg_name = string<br>      }))<br>      subnets = map(object({<br>        description = string<br>        aggregate   = string<br>        ip          = string<br>        scope       = list(string)<br>      }))<br>    }))<br>  })</pre> | n/a | yes |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | n/a | <pre>object({<br>    id    = string<br>    name  = string<br>    })</pre> | n/a | yes |
| <a name="input_vrf_map"></a> [vrf\_map](#input\_vrf\_map) | ## VRF Map ### | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_extepg_map"></a> [extepg\_map](#output\_extepg\_map) | n/a |
| <a name="output_l3out_id"></a> [l3out\_id](#output\_l3out\_id) | n/a |
<!-- END_TF_DOCS -->