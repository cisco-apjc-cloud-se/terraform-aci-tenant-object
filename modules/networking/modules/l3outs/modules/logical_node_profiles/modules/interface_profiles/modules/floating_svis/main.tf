terraform {
  required_providers {
    aci = {
      source  = "CiscoDevNet/aci"
      version = ">=2.0.0"
    }
  }
  experiments = [module_variable_optional_attrs]
}

locals {

  ## Set Defaults ##
  floating_svi = defaults(var.floating_svi, {
    domains = {
      forged_transmit   = "Disabled"
      mac_change        = "Disabled"
      promiscuous_mode  = "Disabled"
    }
  })

  physical_domains = { for k,d in local.floating_svi.domains : k => d if d.type == "physical" }
  vmware_domains = { for k,d in local.floating_svi.domains : k => d if d.type == "vmware" }

  domains = merge(
  {
    for k,d in local.physical_domains : k => merge(d, {
      id    = data.aci_physical_domain.physical[k].id
      })
  },
  {
    for k,d in local.vmware_domains : k => merge(d, {
      id    = data.aci_vmm_domain.vmware[k].id
      })
  }
  )
}

### Load VMware VMM Domains ###
data "aci_vmm_domain" "vmware" {
  for_each = local.vmware_domains

	provider_profile_dn  = "uni/vmmp-VMware"
	name                 = each.value.name
}

### Load Physical Domains ###
data "aci_physical_domain" "physical" {
  for_each = local.physical_domains

  name  = each.value.name
}

resource "aci_l3out_floating_svi" "svi" {
  logical_interface_profile_dn = var.intprof_dn
  node_dn                      = format("topology/pod-%d/node-%d", var.floating_svi.pod, var.floating_svi.node) # "topology/pod-1/node-201"
  encap                        = format("vlan-%d", var.floating_svi.vlan_id)
  addr                         = var.floating_svi.ip ## Anchor Node IP/Mask
  description                  = var.floating_svi.description
  # autostate                    = "enabled"
  # encap_scope                  = "ctx"
  if_inst_t                    = "ext-svi"
  # ipv6_dad                     = "disabled"
  # ll_addr                      = "::"
  # mac                          = "12:23:34:45:56:67"
  # mode                         = "untagged"
  # mtu                          = "580"
  # target_dscp                  = "CS1"

  dynamic "relation_l3ext_rs_dyn_path_att" {
    for_each = local.domains
    content {
      tdn               = relation_l3ext_rs_dyn_path_att.value.id #data.aci_physical_domain.dom.id
      floating_address  = relation_l3ext_rs_dyn_path_att.value.floating_ip ## Floating IP/Mask "10.21.0.254/24"
      forged_transmit   = relation_l3ext_rs_dyn_path_att.value.forged_transmit # "Disabled"
      mac_change        = relation_l3ext_rs_dyn_path_att.value.mac_change # "Disabled"
      promiscuous_mode  = relation_l3ext_rs_dyn_path_att.value.promiscuous_mode # "Disabled"
    }
  }
}

### ACI BGP Peer Profiles Module ###
module "bgp_peers" {
  for_each = var.floating_svi.bgp_peers
  source = "./modules/bgp_peers"

  ### VARIABLES ###
  path_dn  = aci_l3out_floating_svi.svi.id
  bgp_peer  = each.value
}
