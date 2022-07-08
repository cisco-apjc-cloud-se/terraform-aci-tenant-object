output "epg_id" {
  value = try(aci_application_epg.epg[0].id, data.aci_application_epg.epg[0].id)
}

output "dpg_map" {
  value = local.dpg_map
}
