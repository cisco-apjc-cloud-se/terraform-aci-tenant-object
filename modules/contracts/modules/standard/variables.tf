### Contracts Input Variable Object ###
variable "contract" {
  type = object({
    contract_name = string
    tenant_name   = optional(string)
    use_existing  = optional(bool)
    description   = optional(string)
    scope         = optional(string)
    subjects = map(object({
      subject_name  = string
      description   = optional(string)
      filters       = map(object({
        filter_name = string
        tenant_name = optional(string)
      }))
      service_graph = object({
        tenant_name = optional(string)
        template_name = optional(string)
        nodes = map(object({
          node_name     = string
          device = object({
            tenant_name = optional(string)
            device_name = string
          })
          annotation    = optional(string)
          description   = optional(string)
          context       = optional(string)
          name_alias    = optional(string)
          router_config = optional(string)
          consumer_interface = object({
            type                = string
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
          provider_interface = object({
            type                = string
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
        }))
      })
    }))
  })
}

variable "tenant" {
  type = object({
    id    = string
    name  = string
    })
}

variable "filter_map" {}

variable "sgt_map" {}

variable "device_map" {}

variable "srp_map" {}

# variable "bd_map" {}
#
# variable "l3out_map" {}
