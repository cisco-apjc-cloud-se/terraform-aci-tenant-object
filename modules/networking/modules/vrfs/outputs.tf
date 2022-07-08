output "vrf_id" {
  value = try(aci_vrf.vrf[0].id, data.aci_vrf.vrf[0].id)
}
