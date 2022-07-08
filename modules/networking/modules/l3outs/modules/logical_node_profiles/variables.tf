variable "tenant" {
  type = object({
    id    = string
    name  = string
    })
}

variable "l3out_dn" {}

variable "logical_node_profile" {
  type = object({
    lprof_name    = string
    use_existing  = optional(bool)
    description   = string
    bgp_peers = map(object({
      peer_ip                         = string
      peer_asn                        = number
      addr_t_ctrl                     = optional(list(string))
      admin_state                     = optional(string)
      allowed_self_as_cnt             = optional(number)
      description                     = optional(string)
      annotation                      = optional(string)
      ctrl                            = optional(list(string))
      name_alias                      = optional(string)
      password                        = optional(string)
      peer_ctrl                       = optional(list(string))
      private_a_sctrl                 = optional(list(string))
      ttl                             = optional(number)
      weight                          = optional(number)
      local_asn                       = optional(number)
      local_asn_propagate             = optional(string)
      peer_prefix_policy              = optional(string)
      route_control_profiles          = map(object({
        direction = optional(string)
        target_dn = string
      }))
    }))
    nodes = map(object({
      pod         = number
      leaf_node   = number
      loopback_ip = string
    }))
    interface_profiles = map(object({
      intprof_name = string
      description  = string
      ospf_profile = object({
        enabled     = optional(bool)
        description = optional(string)
        auth_key    = optional(string)
        auth_key_id = optional(number)
        auth_type   = optional(string)
        ospf_policy = object({
          tenant_name = optional(string)
          policy_name = optional(string)
          })
      })
      floating_svis = map(object({
        pod         = number
        node        = number
        vlan_id     = number
        ip          = string ## Anchor Node IP
        description = optional(string)
        domains     = map(object({
          name              = string
          type              = string
          floating_ip       = optional(string)
          forged_transmit   = optional(string)
          mac_change        = optional(string)
          promiscuous_mode  = optional(string)
          }))
        }))
      paths = map(object({
        description     = string
        path_type       = string
        ip              = optional(string)
        vlan_id         = optional(number)
        interface_type  = string
        port = object({
          pod       = optional(number)
          node      = optional(number)
          port_name = optional(string)  ## Includes Direct Port Channel
        })
        vpc = object({
          pod         = optional(number)
          vpc_name    = optional(string)
          side_a = object({
            node          = optional(number)
            ip            = optional(string)
            annotation    = optional(string)
            ipv6_dad      = optional(string)
            ll_addr       = optional(string)
            description   = optional(string)
            name_alias    = optional(string)
          })
          side_b = object({
            node          = optional(number)
            ip            = optional(string)
            annotation    = optional(string)
            ipv6_dad      = optional(string)
            ll_addr       = optional(string)
            description   = optional(string)
            name_alias    = optional(string)
          })
        })
        annotation  = optional(string)
        autostate   = optional(string)
        encap_scope = optional(string)
        ipv6_dad    = optional(string)
        ll_addr     = optional(string)
        mac         = optional(string)
        mode        = optional(string)
        mtu         = optional(string)
        target_dscp = optional(string)
      }))
    }))
  })
}
