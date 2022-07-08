terraform {
  required_providers {
    aci = {
      source  = "CiscoDevNet/aci"
      version = ">=2.0.0"
    }
  }
  experiments = [module_variable_optional_attrs]
}

resource "aci_bgp_peer_connectivity_profile" "peer" {
  parent_dn           = var.path_dn
  addr                = var.bgp_peer.peer_ip
  description         = var.bgp_peer.description
  addr_t_ctrl         = var.bgp_peer.addr_t_ctrl
  allowed_self_as_cnt = var.bgp_peer.allowed_self_as_cnt
  annotation          = var.bgp_peer.annotation
  ctrl                = var.bgp_peer.ctrl
  name_alias          = var.bgp_peer.name_alias
  password            = var.bgp_peer.password
  peer_ctrl           = var.bgp_peer.peer_ctrl
  private_a_sctrl     = var.bgp_peer.private_a_sctrl
  ttl                 = var.bgp_peer.ttl
  weight              = var.bgp_peer.weight
  as_number           = var.bgp_peer.peer_asn
  local_asn           = var.bgp_peer.local_asn
  local_asn_propagate = var.bgp_peer.local_asn_propagate
  admin_state         = var.bgp_peer.admin_state

  relation_bgp_rs_peer_pfx_pol = var.bgp_peer.peer_prefix_policy

  dynamic "relation_bgp_rs_peer_to_profile" {
    for_each = var.bgp_peer.route_control_profiles
    content {
      direction = relation_bgp_rs_peer_to_profile.value.direction
      target_dn = relation_bgp_rs_peer_to_profile.value.target_dn #"uni/tn-tenant01/prof-test"
    }
  }
}
