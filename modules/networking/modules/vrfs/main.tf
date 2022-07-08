terraform {
  required_providers {
    aci = {
      source  = "CiscoDevNet/aci"
      version = ">=2.0.0"
    }
  }
  experiments = [module_variable_optional_attrs]
}

### Load Existing VRFs ###
data "aci_vrf" "vrf" {
  count = var.vrf.use_existing == true ? 1 : 0

  name         = var.vrf.vrf_name
  tenant_dn    = var.tenant.id
}

### Create new VRF(s) in Tenant(s) ###
resource "aci_vrf" "vrf" {
  count = var.vrf.use_existing == false ? 1 : 0

  tenant_dn    = var.tenant.id
  name         = var.vrf.vrf_name
  description  = var.vrf.description
  // pc_enf_pref  = each.value.preferred_group # enforced, unenforced
}

### Preferred Group and vzAny ###
resource "aci_any" "vzany" {
  count = var.vrf.use_existing == false ? 1 : 0

  vrf_dn       = aci_vrf.vrf[0].id  ## Same key used
  // description  = "vzAny Description"
  // annotation   = "tag_any"
  // match_t      = "AtleastOne"
  // name_alias   = "alias_any"
  pref_gr_memb = var.vrf.preferred_group
}
