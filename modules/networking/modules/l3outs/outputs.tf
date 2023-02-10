output "l3out_id" {
  value = try(aci_l3_outside.l3out[0].id, data.aci_l3_outside.l3out[0].id)
}

output "extepg_map" {
  value = local.extepg_map
}
