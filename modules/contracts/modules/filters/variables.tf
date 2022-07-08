variable "tenant" {
  type = object({
    id    = string
    name  = string
    })
}

variable "filter" {
  type = object({
    filter_name   = string
    use_existing  = optional(bool)
    tenant_name   = optional(string)
    description   = string
    entries = map(object({
      name        = string
      description = string
      ether_t     = string
      d_from_port = string
      d_to_port   = string
      prot        = string
      s_from_port = string
      s_to_port   = string
      }))
  })
}
