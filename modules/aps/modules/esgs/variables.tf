#### Endpoint Security Groups (ESG) ####
variable "key" {}

variable "ap" {}

variable "vrf_map" {}

variable "tenant_dn" {}

variable "contract_map" {}

variable "esg" {
  type = object({
    esg_name        = string
    use_existing    = optional(bool)
    # vrf_name        = string
    vrf = object({
      tenant_name = optional(string)
      vrf_name    = string
    })
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
  })
}
