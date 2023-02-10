output "esg_id" {
  value = try(aci_endpoint_security_group.esg[0].id, data.aci_endpoint_security_group.esg[0].id)
}

output "internal_consumed_contracts" {
  value = local.internal_consumed_contracts
}

output "internal_provided_contracts" {
  value = local.internal_provided_contracts
}
