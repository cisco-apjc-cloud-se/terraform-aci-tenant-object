### Tenant Details ###
variable "tenant" {
  type = object({
    id    = string
    name  = string
    })
}

### VRF Map ###
variable "vrf_map" {}

### BD Map ###
variable "bd_map" {}

### Contract Map ###
variable "contract_map" {}

### Application Profile ###
variable "ap" {
  type = object({
    ap_name       = string
    use_existing  = optional(bool)
    # tenant_name = string
    description   = string
    #### Endpoint Security Groups (ESG) ####
    esgs = map(object({
      esg_name        = string
      use_existing    = optional(bool)
      # vrf_name        = string
      vrf = object({
        tenant_name = optional(string)
        vrf_name    = string
      })
      description     = string
      preferred_group = string
      consumed_contracts = map(object({
        tenant_name   = optional(string)
        contract_name = string
      }))
      provided_contracts = map(object({
        tenant_name   = optional(string)
        contract_name = string
      }))
    }))
    #### Endpoint Groups (EPG) ####
    epgs = map(object({
      epg_name      = string
      use_existing  = optional(bool)
      # bd_name   = string
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
        # tenant_name = optional(string)
        esg_name    = optional(string)
        })
      preferred_group = optional(string)
      paths = map(object({
        pod       = number
        leaf_node = number
        port      = string
        vlan_id   = number
        mode      = string
        }))
      }))
  })
}
