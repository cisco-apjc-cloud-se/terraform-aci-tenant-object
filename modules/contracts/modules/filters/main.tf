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
  filter = defaults(var.filter, {
    use_existing = false
    })
}

### Load External Tenant ###
data "aci_tenant" "tenant" {
  count = local.filter.tenant_name != null ? 1 : 0

  name = local.filter.tenant_name
}

### Load existing Filter ###
data "aci_filter" "filter" {
  count = local.filter.use_existing == true ? 1 : 0

  tenant_dn   = local.filter.tenant_name != null ? data.aci_tenant.tenant[0].id : var.tenant.id
  name        = local.filter.filter_name

}

### Create new Filter ###

resource "aci_filter" "filter" {
  count = local.filter.use_existing == false ? 1 : 0

  tenant_dn   = var.tenant.id #local.filter.tenant_name != null ? data.aci_tenant.tenant[0].id : var.tenant.id  ## Why create filter outside of tenant??
  description = local.filter.description
  name        = local.filter.filter_name
}

### ACI Filter Entry Module ###
module "entries" {
  for_each  = local.filter.entries
  source    = "./modules/entries"

  ### VARIABLES ###
  filter_dn = local.filter.use_existing == true ? data.aci_filter.filter[0].id : aci_filter.filter[0].id
  entry = each.value
}

# ### Add entries to new or existing Filter ###
#
# resource "aci_filter_entry" "entries" {
#   for_each = local.filter.entries
#
#   filter_dn     = try(aci_filter.filter[0].id, data.aci_filter.filter[0].id)
#   description   = each.value.description
#   name          = each.value.name
#   ether_t       = each.value.ether_t
#   d_from_port   = each.value.d_from_port
#   d_to_port     = each.value.d_to_port
#   prot          = each.value.prot
#   s_from_port   = each.value.s_from_port
#   s_to_port     = each.value.s_to_port
# }
