variable "tenant" {
  type = object({
    id    = string
    name  = string
    })
}

### VRF Map ###
variable "vrf_map" {}

### L3Out Map ###
variable "l3out_map" {}

### Bridge Domain ###
variable "bd" {
  type = object({
    bd_name       = string
    use_existing  = optional(bool)
    vrf = object({
      tenant_name = optional(string)
      vrf_name    = string
      })
    description   = string
    arp_flood     = string
    mac_address   = string
    l3outs        = map(object({
      tenant_name = optional(string)
      l3out_name  = string
      }))
    subnets = map(object({
      description   = string
      ip            = string
      scope         = list(string)
      preferred     = string
      }))
    })
  }
