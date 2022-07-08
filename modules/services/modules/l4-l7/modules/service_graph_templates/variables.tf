variable "tenant" {
  type = object({
    id    = string
    name  = string
    })
}

variable "device_map" {}

## New Single-Object Tenant Model ##
variable "service_graph_template" {
  type = object({
    template_name                     = string
    annotation                        = optional(string)
    name_alias                        = optional(string)
    description                       = optional(string)
    l4_l7_service_graph_template_type = optional(string)
    ui_template_type                  = string
    term_prov_name                    = optional(string)
    term_cons_name                    = optional(string)
    function_nodes = map(object({
      node_name           = string
      annotation          = optional(string)
      description         = optional(string)
      func_template_type  = string
      func_type           = optional(string)
      is_copy             = optional(string)
      managed             = optional(string)
      name_alias          = optional(string)
      routing_mode        = string
      sequence_number     = number
      share_encap         = optional(string)
      device              = object({
        tenant_name = optional(string)
        device_name = string
      })
    }))
    # connections = map(object({
    #   connection_name = string
    #   adj_type        = string
    #   description     = optional(string)
    #   annotation      = optional(string)
    #   conn_dir        = string
    #   conn_type       = optional(string)
    #   direct_connect  = optional(string)
    #   name_alias      = optional(string)
    #   unicast_route   = optional(string)
    # }))
  })
}
