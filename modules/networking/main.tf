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
  vrfs = defaults(var.networking.vrfs, {
    use_existing = false
    })

  bds = defaults(var.networking.bds, {
    use_existing = false
    })

  l3outs = defaults(var.networking.l3outs, {
    use_existing = false
    })

  # ### Tenant Details ###
  # tenant = {
  #   id    = var.tenant_id
  #   name  = var.tenant.name
  #   }

  ### VRF Name => ID Lookup Map ###
  vrf_map = {
    for key, vrf in local.vrfs:
      key => {
        id    = module.vrfs[key].vrf_id
        name  = vrf.vrf_name
      }
    }

  ### BD Name => ID Lookup Map ###
  bd_map = {
    for key, bd in local.bds:
      key => {
        id    = module.bds[key].bd_id
        name  = bd.bd_name
      }
    }

  ### L3Out Name => ID Lookup Map ###
  l3out_map = {
    for key, l3out in local.l3outs:
      key => {
        id          = module.l3outs[key].l3out_id
        extepg_map  = module.l3outs[key].extepg_map
        name        = l3out.l3out_name
      }
    }

}

## ACI VRF Module
module "vrfs" {
  for_each = local.vrfs
  source = "./modules/vrfs"

  ### Variables ###
  vrf       = each.value
  tenant    = var.tenant
}

## ACI BD Module
module "bds" {
  for_each = local.bds
  source = "./modules/bds"

  ### Variables ###
  bd          = each.value
  tenant      = var.tenant
  vrf_map     = local.vrf_map
  l3out_map   = local.l3out_map

}

## ACI L3Out Module
module "l3outs" {
  for_each = local.l3outs
  source = "./modules/l3outs"

  ### Variables ###
  l3out         = each.value
  tenant        = var.tenant
  vrf_map       = local.vrf_map
  contract_map  = var.contract_map

}
