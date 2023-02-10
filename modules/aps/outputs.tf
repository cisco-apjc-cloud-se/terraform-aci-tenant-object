output "ap_id" {
  value = try(aci_application_profile.ap[0].id, data.aci_application_profile.ap[0].id)
}

output "epg_map" {
  value = local.epg_map
}

output "esg_map" {
  value = local.esg_map
}

output "internal_testing" {
  value = local.internal_testing
}
