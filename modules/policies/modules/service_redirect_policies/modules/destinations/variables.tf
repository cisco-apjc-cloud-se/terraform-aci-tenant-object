variable "service_redirect_policy_dn" {}

variable "health_group_map" {}

variable "destination" {
  type = object({
    ip            = string
    mac           = string
    annotation    = optional(string)
    description   = optional(string)
    dest_name     = optional(string)
    ip2           = optional(string) # Default value: "0.0.0.0"
    name_alias    = optional(string)
    pod_id        = optional(number) # Allowed value range: "1" to "255". Default value: "1"
    health_group  = optional(string)
    # relation_vns_rs_redirect_health_group - (Optional) Relation to class vns Redirect Health Group. Cardinality - N_TO_ONE. Type - String.
    })
}
