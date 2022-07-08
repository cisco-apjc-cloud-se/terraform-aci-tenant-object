variable "tenant" {
  type = object({
    id    = string
    name  = string
    })
}

variable "lprof_dn" {}

variable "interface_profile" {
  type = object({
    intprof_name = string
    use_existing = optional(bool)
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
      ip          = string
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
  })
}
