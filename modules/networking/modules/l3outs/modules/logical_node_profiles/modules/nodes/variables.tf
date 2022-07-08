variable "lprof_dn" {}

variable "node" {
  type = object({
    pod         = number
    leaf_node   = number
    loopback_ip = string
  })
}
