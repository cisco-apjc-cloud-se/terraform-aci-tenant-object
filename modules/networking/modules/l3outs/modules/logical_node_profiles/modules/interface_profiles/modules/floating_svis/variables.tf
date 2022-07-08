variable "intprof_dn" {}

variable "floating_svi" {
  type = object({
    pod         = number
    node        = number
    vlan_id     = number
    ip          = string ## Anchor Node IP
    description = optional(string)
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
    domains     = map(object({
      name              = string
      type              = string
      floating_ip       = optional(string)
      forged_transmit   = optional(string) # Disabled, Enabled
      mac_change        = optional(string) # Disabled, Enabled
      promiscuous_mode  = optional(string) # Disabled, Enabled
    }))
  })
}
