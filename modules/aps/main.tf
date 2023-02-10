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
  ap = defaults(var.ap, {
    use_existing = false
    epgs = {
      use_existing = false
    }
    esgs = {
      use_existing = false
    }
    })

  ### App Profile -> EPG Map with ESG Mapping (ONLY) ###
  epg_esg_map = {
    for key, epg in local.ap.epgs :
     key => {
       ap = {
         ap_name       = local.ap.ap_name
         use_existing  = local.ap.use_existing
         id            = try(aci_application_profile.ap[0].id, data.aci_application_profile.ap[0].id)
       }
       mapped_esg = {
         esg_name      = epg.mapped_esg.esg_name
         # id            = lookup(local.esg_map, lower(format("%s-%s-%s", epg.mapped_esg.tenant_name == null ? var.tenant.name : epg.mapped_esg.tenant_name, ap.ap_name, epg.mapped_esg.esg_name)) ).id  ## Lookup ESG ID/DN via Tenant & AP Name
       }
       selected_epg = {
         epg_name = epg.epg_name
         # id = lookup(local.epg_map, lower(format("%s-%s-%s", tenant.name, ap.ap_name, epg.epg_name)) ).id
       }
     }
    if epg.mapped_esg.esg_name != null
  }

  # ap_epg_esg_list = flatten([
  #   # for a_key, ap in tenant.aps : [
  #     for e_key, epg in ap.epgs :
  #       {
  #         # a_key   = a_key
  #         ap = {
  #           ap_name       = ap.ap_name
  #           use_existing  = ap.use_existing
  #           id            = try(aci_application_profile.ap[0].id, data.aci_application_profile.ap[0].id)
  #         }
  #         mapped_esg = {
  #           tenant_name   = epg.mapped_esg.tenant_name == null ? tenant.name : epg.mapped_esg.tenant_name  ## If set, use specified tenant name or default to current tenant
  #           esg_name      = epg.mapped_esg.esg_name
  #           # id            = lookup(local.esg_map, lower(format("%s-%s-%s", epg.mapped_esg.tenant_name == null ? var.tenant.name : epg.mapped_esg.tenant_name, ap.ap_name, epg.mapped_esg.esg_name)) ).id  ## Lookup ESG ID/DN via Tenant & AP Name
  #         }
  #         selected_epg = {
  #           epg_name = epg.epg_name
  #           # id = lookup(local.epg_map, lower(format("%s-%s-%s", tenant.name, ap.ap_name, epg.epg_name)) ).id
  #         }
  #       }
  #       if epg.mapped_esg.esg_name != ""
  #     # ]
  #   ])
  # ap_epg_esg_map = {
  #   for val in local.ap_epg_esg_list:
  #     lower(format("%s-%s", val.ap.ap_name, val.selected_epg.epg_name )) => val
  #   }

  ### EPG Lookup Map ###
  epg_map = {
    for key, epg in local.ap.epgs :
     key => {
       name     = epg.epg_name
       id       = module.epgs[key].epg_id
       dpg_map  = module.epgs[key].dpg_map
     }
  }

  ### ESG Lookup Map ###
  esg_map = {
    for key, esg in local.ap.esgs :
     key => {
       name = esg.esg_name
       id = module.esgs[key].esg_id
     }
  }

  ### internal_consumed_contracts  ###
  internal_testing = {
    for key, esg in local.ap.esgs :
     key => {
       name = esg.esg_name
       internal_consumed_contracts = module.esgs[key].internal_consumed_contracts
       internal_provided_contracts = module.esgs[key].internal_provided_contracts
     }
  }
}

### Load Existing and New APs ###
data "aci_application_profile" "ap" {
  count = local.ap.use_existing == true ? 1 : 0

  tenant_dn   = var.tenant.id
  name        = local.ap.ap_name

}

### Application Profiles ###
resource "aci_application_profile" "ap" {
  count = local.ap.use_existing == false ? 1 : 0

  tenant_dn   = var.tenant.id
  name        = local.ap.ap_name
  description = local.ap.description
}

module "epgs" {
  for_each = local.ap.epgs
  source = "./modules/epgs"

  ### Variables ###
  key       = each.key
  epg       = each.value
  ap        = {
    id = try(aci_application_profile.ap[0].id, data.aci_application_profile.ap[0].id)
    name = local.ap.ap_name
  }
  tenant_dn = var.tenant.id
  bd_map    = var.bd_map

  tenant_name = var.tenant.name
}

module "esgs" {
  for_each = local.ap.esgs
  source = "./modules/esgs"

  ### Variables ###
  key           = each.key
  esg           = each.value
  ap            = {
    id = try(aci_application_profile.ap[0].id, data.aci_application_profile.ap[0].id)
    name = local.ap.ap_name
  }
  tenant_dn     = var.tenant.id
  vrf_map       = var.vrf_map
  contract_map  = var.contract_map
}

module "epg-esg" {
  for_each = local.epg_esg_map
  source = "./modules/epg-esg"

  ### Variables ###
  key      = each.key
  mapping  = each.value

  epg_map  = local.epg_map
  esg_map  = local.esg_map

  # depends_on = [
  #   module.epgs,
  #   module.esgs
  # ]
}
