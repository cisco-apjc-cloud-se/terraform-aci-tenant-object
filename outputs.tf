# output "tenants" {
#   value = data.aci_tenant.tenants
# }
#
# output "tenant_map" {
#   value = local.tenant_map
# }

output "vrf_map" {
  value = module.networking.vrf_map
}

output "bd_map" {
  value = module.networking.bd_map
}

output "l3out_map" {
  value = module.networking.l3out_map
}

output "contract_map" {
  value = module.contracts.contract_map
}

output "ap_id_list" {
  value = [ for k,a in local.tenant.aps : module.aps[k].ap_id ]
}

output "internal_testing" {
  value = local.internal_testing
}

output "ap_epg_map" {
  value = local.ap_epg_map
}
