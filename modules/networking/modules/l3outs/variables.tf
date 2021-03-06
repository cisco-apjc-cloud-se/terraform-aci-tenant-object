variable "tenant" {
  type = object({
    id    = string
    name  = string
    })
}

### VRF Map ###
variable "vrf_map" {}

### Contract Map ###
variable "contract_map" {}

### L3Out Input Variable Object ###
variable "l3out" {
  type = object({
    l3out_name    = string
    use_existing      = optional(bool)
    description   = string
    vrf = object({
      tenant_name = optional(string)
      vrf_name    = string
      })
    l3_domain     = string
    bgp_policy = object({
      enabled     = optional(bool)
      description = optional(string)
      annotation  = optional(string)
      name_alias  = optional(string)
      })
    ospf_policy = object({
      enabled     = optional(bool)
      ## Too many optional?  Should be optional object?
      description = optional(string)
      area_cost   = optional(number)
      area_id     = optional(string)
      area_type   = optional(string)
      })
    logical_node_profiles = map(object({
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
          bgp_peers   = map(object({
            peer_ip                         = string # addr
            peer_asn                        = number # as_number
            addr_t_ctrl                     = optional(list(string)) # Ucast/Mcast Addr Type AF Control. (Multiple Comma-Delimited values are allowed. E.g., "af-mcast,af-ucast"). Apply "" to clear all the values. Allowed values: "af-mcast", "af-ucast". Default value: "af-ucast".
            admin_state                     = optional(string) # Allowed values are "disabled", "enabled", and default value is "enabled"
            allowed_self_as_cnt             = optional(number) # Default value: "3".
            description                     = optional(string)
            annotation                      = optional(string)
            ctrl                            = optional(list(string)) # Allowed values: "allow-self-as", "as-override", "dis-peer-as-check", "nh-self", "send-com", "send-ext-com"
            name_alias                      = optional(string)
            password                        = optional(string) # If password is set, the peer password will reset when terraform configuration is applied.
            peer_ctrl                       = optional(list(string)) # Allowed values: "bfd", "dis-conn-check".
            private_a_sctrl                 = optional(list(string)) # Allowed values: "remove-all", "remove-exclusive", "replace-as".
            ttl                             = optional(number) # Default value: "1".
            weight                          = optional(number) # Default value: "0".
            local_asn                       = optional(number)
            local_asn_propagate             = optional(string) # Allowed values: "dual-as", "no-prepend", "none", "replace-as". Default value: "none".
            peer_prefix_policy              = optional(string)
            route_control_profiles          = map(object({
              direction = optional(string) # Allowed values are "export", "import", and default value is "import".
              target_dn = string
            }))
          }))
        }))
      }))
    }))
    ## NOTE: Only NEW (managed) ExtEPGs supported - can't change contracts on existing ExtEPGs
    external_epgs = map(object({
      extepg_name     = string
      use_existing    = optional(bool)
      description     = string
      preferred_group = string
      consumed_contracts = map(object({
        tenant_name   = optional(string)
        contract_name = string
      }))
      provided_contracts = map(object({
        tenant_name   = optional(string)
        contract_name = string
      }))
      contract_master_epgs = map(object({
        l3out_name = string
        extepg_name = string
      }))
      subnets = map(object({
        description = string
        aggregate   = string
        ip          = string
        scope       = list(string)
      }))
    }))
  })
}
