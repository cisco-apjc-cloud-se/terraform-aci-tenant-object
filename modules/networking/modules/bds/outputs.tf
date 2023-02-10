output "bd_id" {
  value = try(aci_bridge_domain.bd[0].id, data.aci_bridge_domain.bd[0].id)
}
