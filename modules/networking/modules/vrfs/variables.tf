variable "tenant" {
  type = object({
    id    = string
    name  = string
    })
}

variable "vrf" {
  type = object({
    vrf_name        = string
    use_existing    = optional(bool)
    description     = string
    preferred_group = string
    })
}
