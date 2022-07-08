terraform {
  required_providers {
    aci = {
      source  = "CiscoDevNet/aci"
      version = ">=2.0.0"
    }
  }
  experiments = [module_variable_optional_attrs]
}

### Locals ###
locals {
  contract = defaults(var.contract, {
    use_existing = false
    })
  # new_contracts = { for key, contract in local.contracts: key => contract if contract.existing == false }
}

# locals {
#   new_contracts = try({ for key, contract in var.contracts: key => contract if contract.existing == false }, {})
#   existing_contracts = try({ for key, contract in var.contracts: key => contract if contract.existing == true }, {})
#   existing_tenants = try(distinct([ for key, contract in var.contracts: contract.tenant_name if contract.existing == true ]),{})
# }

# ### Existing Contracts ###
# data "aci_tenant" "existing" {
#   for_each    = toset(local.existing_tenants)
#
#   name        = each.value
# }

# data "aci_contract" "existing" {
#   for_each = local.existing_contracts
#
#   tenant_dn   = data.aci_tenant.existing[each.value.tenant_name].id
#   name        = each.value.contract_name
# }

### Load External Tenant ###
data "aci_tenant" "tenant" {
  count = local.contract.tenant_name != null ? 1 : 0

  name = local.contract.tenant_name
}

### Load existing Contract ###

data "aci_contract" "contract" {
  count = local.contract.use_existing == true ? 1 : 0

  tenant_dn   = local.contract.tenant_name != null ? data.aci_tenant.tenant[0].id : var.tenant.id
  name        = local.contract.contract_name
}

### New Contract ###
resource "aci_contract" "contract" {
  count = local.contract.use_existing == false ? 1 : 0

  tenant_dn   = var.tenant.id
  description = local.contract.description
  name        = local.contract.contract_name
  scope       = local.contract.scope
}

### ACI Subject Modues ###
module "subjects" {
  for_each = local.contract.subjects
  source = "./modules/subjects"

  ### Variables ###
  contract_dn = local.contract.tenant_name != null ? data.aci_contract.contract[0].id :  aci_contract.contract[0].id # try(aci_contract.contract[0].id, data.aci_contract.contract[0].id)
  tenant      = var.tenant
  filter_map  = var.filter_map
  subject     = each.value

  ### L4-7 Service Graph ###
  contract_name   = local.contract.contract_name
  sgt_map         = var.sgt_map
  device_map      = var.device_map
  srp_map         = var.srp_map
  # bd_map          = var.bd_map
  # l3out_map       = var.l3out_map
}
