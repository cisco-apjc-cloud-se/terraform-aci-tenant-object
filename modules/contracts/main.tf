terraform {
  required_providers {
    aci = {
      source  = "CiscoDevNet/aci"
      version = ">=2.0.0"
    }
  }
  experiments = [module_variable_optional_attrs]
}

locals {
  ### Filter Name => ID Lookup Map ###
  filter_map = {
    for key, filter in var.contracts.filters:
      key => {
        id    = module.filters[key].filter_id
        name  = filter.filter_name
      }
    }

  ### Contract Name => ID Lookup Map ###
  contract_map = {
    for key, contract in var.contracts.standard:
      key => {
        id    = module.standard[key].contract_id
        name  = contract.contract_name
      }
    }
}

## ACI Standard Contracts Module
module "standard" {
  for_each = var.contracts.standard
  source = "./modules/standard"

  ### Variables ###
  contract = each.value
  tenant   = var.tenant
  filter_map  = local.filter_map
  sgt_map     = var.sgt_map
  device_map  = var.device_map
  srp_map     = var.srp_map
  # bd_map      = var.bd_map
  # l3out_map   = var.l3out_map
}

## ACI Filters Module
module "filters" {
  for_each = var.contracts.filters
  source = "./modules/filters"

  ### Variables ###
  filter = each.value
  tenant = var.tenant
}
