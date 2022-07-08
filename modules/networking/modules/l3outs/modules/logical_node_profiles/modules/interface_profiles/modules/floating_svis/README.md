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

## Resources

| Name | Type |
|------|------|
| [aci_l3out_floating_svi.svi](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/l3out_floating_svi) | resource |
| [aci_physical_domain.physical](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/data-sources/physical_domain) | data source |
| [aci_vmm_domain.vmware](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/data-sources/vmm_domain) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_floating_svi"></a> [floating\_svi](#input\_floating\_svi) | n/a | <pre>object({<br>    pod         = number<br>    node        = number<br>    vlan_id     = number<br>    ip          = string ## Anchor Node IP<br>    description = optional(string)<br>    bgp_peers   = map(object({<br>      peer_ip                         = string # addr<br>      peer_asn                        = number # as_number<br>      addr_t_ctrl                     = optional(list(string)) # Ucast/Mcast Addr Type AF Control. (Multiple Comma-Delimited values are allowed. E.g., "af-mcast,af-ucast"). Apply "" to clear all the values. Allowed values: "af-mcast", "af-ucast". Default value: "af-ucast".<br>      admin_state                     = optional(string) # Allowed values are "disabled", "enabled", and default value is "enabled"<br>      allowed_self_as_cnt             = optional(number) # Default value: "3".<br>      description                     = optional(string)<br>      annotation                      = optional(string)<br>      ctrl                            = optional(list(string)) # Allowed values: "allow-self-as", "as-override", "dis-peer-as-check", "nh-self", "send-com", "send-ext-com"<br>      name_alias                      = optional(string)<br>      password                        = optional(string) # If password is set, the peer password will reset when terraform configuration is applied.<br>      peer_ctrl                       = optional(list(string)) # Allowed values: "bfd", "dis-conn-check".<br>      private_a_sctrl                 = optional(list(string)) # Allowed values: "remove-all", "remove-exclusive", "replace-as".<br>      ttl                             = optional(number) # Default value: "1".<br>      weight                          = optional(number) # Default value: "0".<br>      local_asn                       = optional(number)<br>      local_asn_propagate             = optional(string) # Allowed values: "dual-as", "no-prepend", "none", "replace-as". Default value: "none".<br>      peer_prefix_policy              = optional(string)<br>      route_control_profiles          = map(object({<br>        direction = optional(string) # Allowed values are "export", "import", and default value is "import".<br>        target_dn = string<br>      }))<br>    }))<br>    domains     = map(object({<br>      name              = string<br>      type              = string<br>      floating_ip       = optional(string)<br>      forged_transmit   = optional(string) # Disabled, Enabled<br>      mac_change        = optional(string) # Disabled, Enabled<br>      promiscuous_mode  = optional(string) # Disabled, Enabled<br>    }))<br>  })</pre> | n/a | yes |
| <a name="input_intprof_dn"></a> [intprof\_dn](#input\_intprof\_dn) | n/a | `any` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->