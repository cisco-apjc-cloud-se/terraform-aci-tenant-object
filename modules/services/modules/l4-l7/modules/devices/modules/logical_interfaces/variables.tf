variable "l4_l7_dn" {}

variable "int_map" {}

variable "interface" {
  type = object({
    interface_name            = string
    annotation                = optional(string)
    encap                     = optional(string)
    enhanced_lag_policy_name  = optional(string)
    # concrete_interfaces       = list(string)  # Links by interface_name
  })
}
