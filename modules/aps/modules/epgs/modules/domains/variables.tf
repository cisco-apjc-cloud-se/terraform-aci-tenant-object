variable "domain" {
  type = object({
    name                  = string
    type                  = string
    vmm_allow_promiscuous = optional(string)
    vmm_forged_transmits  = optional(string)
    vmm_mac_changes       = optional(string)
    })
}

variable "epg_id" {}

variable "tenant_name" {}
variable "ap_name" {}
variable "epg_name" {}
