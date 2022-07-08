terraform {
  required_providers {
    aci = {
      source  = "CiscoDevNet/aci"
      version = ">=2.0.0"
    }
  }
  experiments = [module_variable_optional_attrs]
}

### Load VMware VMM Domains ###
data "aci_vmm_domain" "vmware" {
  count = var.domain.type == "vmware" ? 1 : 0

	provider_profile_dn  = "uni/vmmp-VMware"
	name                 = var.domain.name
}

### Load Physical Domains ###
data "aci_physical_domain" "physical" {
  count = var.domain.type == "physical" ? 1 : 0

  name  = var.domain.name
}

### Associate Physical Domain(s) for Static EPGs ###
resource "aci_epg_to_domain" "physical" {
  count = var.domain.type == "physical" ? 1 : 0

  application_epg_dn    = var.epg_id
  tdn                   = data.aci_physical_domain.physical[0].id
}

### Create VMware Distributed Port Groups via ACI VMM Domain ###
resource "aci_epg_to_domain" "vmware" {
  count = var.domain.type == "vmware" ? 1 : 0

  application_epg_dn    = var.epg_id
  tdn                   = data.aci_vmm_domain.vmware[0].id
  vmm_allow_promiscuous = var.domain.vmm_allow_promiscuous
  vmm_forged_transmits  = var.domain.vmm_forged_transmits
  vmm_mac_changes       = var.domain.vmm_mac_changes
}
