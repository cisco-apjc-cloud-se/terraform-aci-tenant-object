variable "external_epg_dn" {}

variable "subnet" {
  type = object({
    description = string
    aggregate   = string
    ip          = string
    scope       = list(string)
  })
}
