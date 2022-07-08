variable "intprof_dn" {}

variable "path" {
  type = object({
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
    autostate   = optional(string) # Allowed values: "disabled", "enabled". Default value is "disabled".
    encap_scope = optional(string) # Allowed values: "ctx", "local". Default value is "local".
    ipv6_dad    = optional(string) # Allowed values: "disabled", "enabled". Default value is "enabled".
    ll_addr     = optional(string) # Default value is "::".
    mac         = optional(string) # Default value is "00:22:BD:F8:19:FF".
    mode        = optional(string) # Allowed values: "native", "regular", "untagged". Default value is "regular".
    mtu         = optional(string) # Range of allowed values is "576" to "9216". Default value is "inherit".
    target_dscp = optional(string) # Default value: "unspecified". Allowed values: "AF11", "AF12", "AF13", "AF21", "AF22", "AF23", "AF31", "AF32", "AF33", "AF41", "AF42", "AF43", "CS0", "CS1", "CS2", "CS3", "CS4", "CS5", "CS6", "CS7", "EF", "VA", "unspecified". Default value: "unspecified".
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
  })
}
