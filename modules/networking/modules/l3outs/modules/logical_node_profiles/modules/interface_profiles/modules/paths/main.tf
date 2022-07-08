terraform {
  required_providers {
    aci = {
      source  = "CiscoDevNet/aci"
      version = ">=2.0.0"
    }
  }
  experiments = [module_variable_optional_attrs]
}

### Locals ###
locals {
  target_dn = var.path.interface_type == "port" ? format("topology/pod-%d/paths-%d/pathep-[%s]", var.path.port.pod, var.path.port.node, var.path.port_name) : var.path.interface_type == "vpc" ? format("topology/pod-%d/protpaths-%d-%d/pathep-[%s]", var.path.vpc.pod, var.path.vpc.side_a.node, var.path.vpc.side_b.node, var.path.vpc.vpc_name) : null
}

### L3Out Interface Path Attachment ###
resource "aci_l3out_path_attachment" "path" {
  logical_interface_profile_dn  = var.intprof_dn
  target_dn                     = local.target_dn #format("topology/pod-%d/paths-%d/pathep-[%s]", var.path.pod, var.path.leaf_node, var.path.port)
  if_inst_t                     = var.path.path_type  # "ext-svi", "l3-port", "sub-interface", "unspecified"
  description                   = var.path.description
  addr                          = var.path.ip
  encap                         = var.path.path_type == "l3-port" ? "unknown" : format("vlan-%d", var.path.vlan_id)  # set to "unknown" for l3-port types #var.path.encap
  annotation                    = var.path.annotation
  autostate                     = var.path.autostate
  encap_scope                   = var.path.encap_scope
  ipv6_dad                      = var.path.ipv6_dad
  ll_addr                       = var.path.ll_addr
  mac                           = var.path.mac
  mode                          = var.path.mode
  mtu                           = var.path.mtu
  target_dscp                   = var.path.target_dscp
}

resource "aci_l3out_vpc_member" "side_a" {
  count = var.path.interface_type == "vpc" ? 1 : 0

  leaf_port_dn  = aci_l3out_path_attachment.path.id
  side          = "A"
  addr          = var.path.vpc.side_a.ip
  annotation    = var.path.vpc.side_a.annotation
  ipv6_dad      = var.path.vpc.side_a.ipv6_dad
  ll_addr       = var.path.vpc.side_a.ll_addr
  description   = var.path.vpc.side_a.description
  name_alias    = var.path.vpc.side_a.name_alias
}

resource "aci_l3out_vpc_member" "side_b" {
  count = var.path.interface_type == "vpc" ? 1 : 0

  leaf_port_dn  = aci_l3out_path_attachment.path.id
  side          = "B"
  addr          = var.path.vpc.side_b.ip
  annotation    = var.path.vpc.side_b.annotation
  ipv6_dad      = var.path.vpc.side_b.ipv6_dad
  ll_addr       = var.path.vpc.side_b.ll_addr
  description   = var.path.vpc.side_b.description
  name_alias    = var.path.vpc.side_b.name_alias
}
