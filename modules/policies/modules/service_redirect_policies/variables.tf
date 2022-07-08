variable "tenant" {
  type = object({
    id    = string
    name  = string
    })
}

variable "service_redirect_policy" {
  type = object({
    policy_name             = string
    name_alias              = optional(string)
    use_existing            = optional(bool)
    description             = optional(string)
    dest_type               = optional(string) # "L1", "L2", "L3". Default value: "L3".
    min_threshold_percent   = optional(number) # 0
    max_threshold_percent   = optional(number) # 0
    hashing_algorithm       = optional(string) # "sip", "dip", "sip-dip-prototype", Default value: "sip-dip-prototype".
    ## NOTE: anycast_enabled and program_local_pod_only cannot be "yes" simultaneously.
    anycast_enabled         = optional(string) # Allowed values: "yes", "no". Default value: "no".
    program_local_pod_only  = optional(string) # Allowed values: "yes", "no". Default value: "no".
    resilient_hash_enabled  = optional(string) # Allowed values: "yes", "no". Default value: "no".
    threshold_enable        = optional(string) # Allowed values: "yes", "no". Default value: "no".
    threshold_down_action   = optional(string) # Allowed values: "bypass", "deny", "permit". Default value: "permit".
    ipsla_policy            = optional(string) # relation_vns_rs_ipsla_monitoring_pol
    destinations = map(object({
      ip            = string
      mac           = string
      annotation    = optional(string)
      description   = optional(string)
      dest_name     = optional(string)
      ip2           = optional(string)
      name_alias    = optional(string)
      pod_id        = optional(number)
      health_group  = optional(string)
    }))
  })
}
