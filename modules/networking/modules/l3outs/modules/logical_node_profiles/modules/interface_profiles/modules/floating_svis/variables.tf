variable "intprof_dn" {}

variable "floating_svi" {
  type = object({
    pod         = number
    node        = number
    vlan_id     = number
    ip          = string ## Anchor Node IP
    description = optional(string)
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
