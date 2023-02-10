output "contract_id" {
  value = local.contract.tenant_name != null ? data.aci_contract.contract[0].id :  aci_contract.contract[0].id #try(aci_contract.contract[0].id, data.aci_contract.contract[0].id)
}
