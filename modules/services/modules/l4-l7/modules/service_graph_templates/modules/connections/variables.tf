variable "template_dn" {}

## New Single-Object Tenant Model ##
variable "connection" {
  type = object({
    connection_name = string
    adj_type        = string # Allowed values are "L2", "L3". Default value is "L2".
    description     = optional(string)
    annotation      = optional(string)
    conn_dir        = string # Allowed values are "consumer", "provider". Default value is "provider".
    conn_type       = optional(string) # Allowed values are "external", "internal". Default value is "external".
    direct_connect  = optional(string) # Allowed values are "yes" and "no". Default value is "no".
    name_alias      = optional(string)
    unicast_route   = optional(string) # Unicast route setting should be true for L3 connections. Allowed values are "yes" and "no". Default value is "yes".
    dn_list         = list(string)
  })
}
