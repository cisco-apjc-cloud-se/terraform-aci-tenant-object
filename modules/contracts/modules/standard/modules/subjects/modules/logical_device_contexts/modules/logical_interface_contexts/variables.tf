variable "logical_device_context_dn" {}

variable "logical_int_map" {}

variable "srp_map" {}

variable "tenant_dn" {}

# variable "bd_map" {}
#
# variable "l3out_map" {}

variable "interface" {
  type = object({
    type                = string  # "general" or "route_peering"
    conn_name           = string
    cluster_interface   = string
    l3_dest             = optional(string)
    redirect_policy     = optional(string)
    service_epg_policy  = optional(string)
    annotation          = optional(string)
    description         = optional(string)
    name_alias          = optional(string)
    permit_log          = optional(string)
    bd = object({
      tenant_name = optional(string)
      bd_name     = optional(string)
    })
    extepg = object({
      tenant_name = optional(string)
      l3out_name  = optional(string)
      extepg_name = optional(string)
    })
  })
}
