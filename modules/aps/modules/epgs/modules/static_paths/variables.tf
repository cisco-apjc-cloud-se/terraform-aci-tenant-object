variable "path" {
  type = object({
    pod       = number
    leaf_node = number
    port      = string
    vlan_id   = number
    mode      = string
    })
}

variable "epg_id" {}
