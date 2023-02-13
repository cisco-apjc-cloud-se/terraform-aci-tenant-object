#### Endpoint Groups (EPG) ####
variable "key" {}

variable "ap" {}

variable "bd_map" {}

variable "tenant_dn" {}

variable "epg" {
  type = object({
    epg_name      = string
    use_existing  = optional(bool)
    bd = object({
      tenant_name = optional(string)
      bd_name = string
    })
    description = string
    domains = map(object({
      name = string
      type = string
      vmm_allow_promiscuous = optional(string)
      vmm_forged_transmits  = optional(string)
      vmm_mac_changes       = optional(string)
      }))
    mapped_esg = object({
      esg_name    = optional(string)
      })
    fwd_ctrl                = optional(string)
    intraepg_isolation      = optional(string)
    preferred_group         = optional(string)
    paths = map(object({
      pod       = number
      leaf_node = number
      port      = string
      vlan_id   = number
      mode      = string
      }))
    })
}

## For VMware DPG Name ###
variable "tenant_name" {}

# {
#   t_key   = t_key
#   a_key   = a_key
#   tenant  = {
#     name          = tenant.name
#     id            = lookup(var.tenant_map, tenant.name).id
#     use_existing  = tenant.use_existing
#   }
#   ap = {
#     ap_name       = ap.ap_name
#     use_existing  = ap.use_existing
#     id            = lookup(var.ap_map, lower(format("%s-%s", tenant.name, ap.ap_name)) ).id  ## Lookup AP ID/DN via Tenant & AP Name
#   }
#   bd = {
#     tenant_name   = epg.bd.tenant_name == null ? tenant.name : epg.bd.tenant_name  ## If set, use specified tenant name or default to current tenant
#     bd_name       = epg.bd.bd_name
#     id            = lookup(var.bd_map, lower(format("%s-%s", epg.bd.tenant_name == null ? tenant.name : epg.bd.tenant_name, epg.bd_name)) ).id  ## Lookup BD ID/DN via Tenant & AP Name
#   }
#   epg = epg
# }
