terraform {
  required_providers {
    aci = {
      source  = "CiscoDevNet/aci"
      version = ">=2.0.0"
    }
  }
  # experiments = [module_variable_optional_attrs]
}

### Bind EPG to Static Path(s) ###
resource "aci_epg_to_static_path" "path" {

  application_epg_dn  = var.epg_id  ## Assumes AP Name & EPG Name also used for map/object key
  tdn                 = format("topology/pod-%d/paths-%d/pathep-[%s]", var.path.pod, var.path.leaf_node, var.path.port) #"topology/pod-1/paths-129/pathep-[eth1/3]"
  encap               = format("vlan-%d", var.path.vlan_id)
  mode                = var.path.mode
}
