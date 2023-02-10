variable "concrete_dn" {}

variable "domain" {}

variable "interface" {
  type = object({
    interface_name  = string
    encap           = optional(string)
    vnic_name       = optional(string)
    pod             = optional(number)
    node            = optional(number)
    port            = optional(string)
    })
}
