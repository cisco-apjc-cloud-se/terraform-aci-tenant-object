output "extepg_id" {
  value = local.external_epg.use_existing == true ? data.aci_external_network_instance_profile.extepg[0].id : aci_external_network_instance_profile.extepg[0].id
}
