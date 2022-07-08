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
| [aci_l3out_path_attachment.path](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/l3out_path_attachment) | resource |
| [aci_l3out_vpc_member.side_a](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/l3out_vpc_member) | resource |
| [aci_l3out_vpc_member.side_b](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/l3out_vpc_member) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_intprof_dn"></a> [intprof\_dn](#input\_intprof\_dn) | n/a | `any` | n/a | yes |
| <a name="input_path"></a> [path](#input\_path) | n/a | <pre>object({<br>    description     = string<br>    path_type       = string<br>    ip              = optional(string)<br>    vlan_id         = optional(number)<br>    interface_type  = string<br>    port = object({<br>      pod       = optional(number)<br>      node      = optional(number)<br>      port_name = optional(string)  ## Includes Direct Port Channel<br>    })<br>    vpc = object({<br>      pod         = optional(number)<br>      vpc_name    = optional(string)<br>      side_a = object({<br>        node          = optional(number)<br>        ip            = optional(string)<br>        annotation    = optional(string)<br>        ipv6_dad      = optional(string)<br>        ll_addr       = optional(string)<br>        description   = optional(string)<br>        name_alias    = optional(string)<br>      })<br>      side_b = object({<br>        node          = optional(number)<br>        ip            = optional(string)<br>        annotation    = optional(string)<br>        ipv6_dad      = optional(string)<br>        ll_addr       = optional(string)<br>        description   = optional(string)<br>        name_alias    = optional(string)<br>      })<br>    })<br>    annotation  = optional(string)<br>    autostate   = optional(string) # Allowed values: "disabled", "enabled". Default value is "disabled".<br>    encap_scope = optional(string) # Allowed values: "ctx", "local". Default value is "local".<br>    ipv6_dad    = optional(string) # Allowed values: "disabled", "enabled". Default value is "enabled".<br>    ll_addr     = optional(string) # Default value is "::".<br>    mac         = optional(string) # Default value is "00:22:BD:F8:19:FF".<br>    mode        = optional(string) # Allowed values: "native", "regular", "untagged". Default value is "regular".<br>    mtu         = optional(string) # Range of allowed values is "576" to "9216". Default value is "inherit".<br>    target_dscp = optional(string) # Default value: "unspecified". Allowed values: "AF11", "AF12", "AF13", "AF21", "AF22", "AF23", "AF31", "AF32", "AF33", "AF41", "AF42", "AF43", "CS0", "CS1", "CS2", "CS3", "CS4", "CS5", "CS6", "CS7", "EF", "VA", "unspecified". Default value: "unspecified".<br>    bgp_peers   = map(object({<br>      peer_ip                         = string # addr<br>      peer_asn                        = number # as_number<br>      addr_t_ctrl                     = optional(list(string)) # Ucast/Mcast Addr Type AF Control. (Multiple Comma-Delimited values are allowed. E.g., "af-mcast,af-ucast"). Apply "" to clear all the values. Allowed values: "af-mcast", "af-ucast". Default value: "af-ucast".<br>      admin_state                     = optional(string) # Allowed values are "disabled", "enabled", and default value is "enabled"<br>      allowed_self_as_cnt             = optional(number) # Default value: "3".<br>      description                     = optional(string)<br>      annotation                      = optional(string)<br>      ctrl                            = optional(list(string)) # Allowed values: "allow-self-as", "as-override", "dis-peer-as-check", "nh-self", "send-com", "send-ext-com"<br>      name_alias                      = optional(string)<br>      password                        = optional(string) # If password is set, the peer password will reset when terraform configuration is applied.<br>      peer_ctrl                       = optional(list(string)) # Allowed values: "bfd", "dis-conn-check".<br>      private_a_sctrl                 = optional(list(string)) # Allowed values: "remove-all", "remove-exclusive", "replace-as".<br>      ttl                             = optional(number) # Default value: "1".<br>      weight                          = optional(number) # Default value: "0".<br>      local_asn                       = optional(number)<br>      local_asn_propagate             = optional(string) # Allowed values: "dual-as", "no-prepend", "none", "replace-as". Default value: "none".<br>      peer_prefix_policy              = optional(string)<br>      route_control_profiles          = map(object({<br>        direction = optional(string) # Allowed values are "export", "import", and default value is "import".<br>        target_dn = string<br>      }))<br>    }))<br>  })</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->