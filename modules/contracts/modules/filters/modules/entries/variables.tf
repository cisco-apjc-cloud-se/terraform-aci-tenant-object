variable "filter_dn" {}

variable "entry" {
  type = object({
    name        = string
    description = string
    ether_t     = string
    d_from_port = string
    d_to_port   = string
    prot        = string
    s_from_port = string
    s_to_port   = string
    })
}
