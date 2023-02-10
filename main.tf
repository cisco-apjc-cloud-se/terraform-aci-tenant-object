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
  ### Set Defaults ###
  tenant = defaults(var.tenant, {
    use_existing = false
    })

  ### internal_consumed_contracts  ###
  internal_testing = {
    for key, ap in local.tenant.aps :
     key => {
       ap_name = ap.ap_name
       internal_testing = module.aps[key].internal_testing
     }
  }

  ### EPG Lookup Map ###
  ap_epg_map = {
    for key, ap in local.tenant.aps :
     key => {
       ap_name = ap.ap_name
       epg_map  = module.aps[key].epg_map
     }
  }
}

### Load Existing Tenant ###
data "aci_tenant" "tenant" {
  count = var.tenant.use_existing == true ? 1 : 0

  name        = var.tenant.name
}

### Build New Tenant ###
resource "aci_tenant" "tenant" {
  count = var.tenant.use_existing == false ? 1 : 0

  name        = var.tenant.name
  description = var.tenant.description
  annotation  = "orchestrator:Terraform"
}

### Networking Section Module ###
module "networking" {
  source = "./modules/networking"

  ### Variables ###
  networking = var.tenant.networking
  tenant = {
    name  = local.tenant.use_existing == true ? data.aci_tenant.tenant[0].name : aci_tenant.tenant[0].name
    id    = local.tenant.use_existing == true ? data.aci_tenant.tenant[0].id : aci_tenant.tenant[0].id
  }
  contract_map  = module.contracts.contract_map

}

### Application Profile Section Module ###
module "aps" {
  for_each = local.tenant.aps
  source = "./modules/aps"

  ### Variables ###
  ap =  each.value
  tenant = {
    name  = local.tenant.use_existing == true ? data.aci_tenant.tenant[0].name : aci_tenant.tenant[0].name
    id    = local.tenant.use_existing == true ? data.aci_tenant.tenant[0].id : aci_tenant.tenant[0].id
  }
  vrf_map       = module.networking.vrf_map
  bd_map        = module.networking.bd_map
  contract_map  = module.contracts.contract_map

}

### Contracts & Filters Section Module ###
module "contracts" {
  source = "./modules/contracts"

  ### Variables ###
  contracts  = var.tenant.contracts
  tenant = {
    name  = local.tenant.use_existing == true ? data.aci_tenant.tenant[0].name : aci_tenant.tenant[0].name
    id    = local.tenant.use_existing == true ? data.aci_tenant.tenant[0].id : aci_tenant.tenant[0].id
  }
  sgt_map     = module.services.sgt_map
  device_map  = module.services.device_map
  srp_map     = module.policies.srp_map
}

### Policies Section Module ###
module "policies" {
  source = "./modules/policies"

  ### Variables ###
  tenant = {
    name  = local.tenant.use_existing == true ? data.aci_tenant.tenant[0].name : aci_tenant.tenant[0].name
    id    = local.tenant.use_existing == true ? data.aci_tenant.tenant[0].id : aci_tenant.tenant[0].id
  }
  policies  = var.tenant.policies
}

### Services Section Module ###
module "services" {
  source = "./modules/services"

  ### Variables ###
  tenant = {
    name  = local.tenant.use_existing == true ? data.aci_tenant.tenant[0].name : aci_tenant.tenant[0].name
    id    = local.tenant.use_existing == true ? data.aci_tenant.tenant[0].id : aci_tenant.tenant[0].id
  }
  services  = var.tenant.services
}
