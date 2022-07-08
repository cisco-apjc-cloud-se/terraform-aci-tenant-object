variable "tenant" {
  type = object({
    id    = string
    name  = string
    })
}

variable "l3out_dn" {}

variable "contract_map" {}

variable "external_epg" {
  type = object({
    extepg_name     = string
    use_existing    = optional(bool)
    description     = string
    preferred_group = string
    consumed_contracts = map(object({
      tenant_name   = optional(string)
      contract_name = string
    }))
    provided_contracts = map(object({
      tenant_name   = optional(string)
      contract_name = string
    }))
    contract_master_epgs = map(object({
      l3out_name = string
      extepg_name = string
    }))
    subnets = map(object({
      description = string
      aggregate   = string
      ip          = string
      scope       = list(string)
    }))
  })
}
