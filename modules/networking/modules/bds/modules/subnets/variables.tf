variable "parent_dn" {
  type = string
}

### Bridge Domain ###
variable "subnet" {
  type = object({
    description   = string
    ip            = string
    scope         = list(string)
    preferred     = string
    })
  }
