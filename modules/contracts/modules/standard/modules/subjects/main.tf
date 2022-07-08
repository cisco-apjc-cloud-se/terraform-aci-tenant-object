terraform {
  required_providers {
    aci = {
      source  = "CiscoDevNet/aci"
      version = ">=2.0.0"
    }
  }
  experiments = [module_variable_optional_attrs]
}


## Build Tenant Lookup List ##
locals {
  external_filters = {
    for k,f in var.subject.filters :
     k => f
    if f.tenant_name != null
  }
  internal_filters = {
    for k,f in var.subject.filters :
     k => f
    if f.tenant_name == null
  }

  external_filter_tenants_list = distinct([for k,f in local.external_filters : f.tenant_name ])

  filters = merge({
    for k,f in local.external_filters :
      k => {
        filter_name = f.filter_name
        id = data.aci_filter.external_filter[k].id
      }
    },
    {
    for k,f in local.internal_filters :
      k => {
        filter_name = f.filter_name
        id = var.filter_map[f.filter_name].id
      }
    })

}

### Load existing Service Graph ###
data "aci_tenant" "external_service_graph_tenant" {
  count = var.subject.service_graph.tenant_name != null ? 1 : 0

  name        = var.subject.service_graph.tenant_name
}

data "aci_l4_l7_service_graph_template" "external_service_graph_template" {
  count = var.subject.service_graph.tenant_name != null ? 1 : 0

  tenant_dn = data.aci_tenant.external_service_graph_tenant[0].id
  name      = var.subject.service_graph.template_name
}


### Load existing Filter ###
data "aci_tenant" "external_filter_tenants" {
  for_each = toset(local.external_filter_tenants_list)
  name        = each.value
}

data "aci_filter" "external_filter" {
  for_each = local.external_filters

  tenant_dn   = each.value.tenant_name != null ? data.aci_tenant.external_filter_tenants[each.value.tenant_name].id : var.tenant.id
  name        = each.value.filter_name
}

resource "aci_contract_subject" "subject" {
  contract_dn   = var.contract_dn
  description   = var.subject.description
  name          = var.subject.subject_name
  relation_vz_rs_subj_filt_att = [
    for k,f in local.filters : f.id
    # for k,f in var.subject.filters : data.aci_filter.filter[k].id ## Assumes same key and key is unique
  ]

  ### L4-7 Service Graph Association ###
  relation_vz_rs_subj_graph_att = var.subject.service_graph.tenant_name != null ? data.aci_l4_l7_service_graph_template.external_service_graph_template[0].id : var.subject.service_graph.template_name != null ? var.sgt_map[var.subject.service_graph.template_name].id : null
}

### L4-L7 Service Graph Logical Device Context Module ###
module "logical_device_contexts" {
  for_each = var.subject.service_graph.nodes
  source = "./modules/logical_device_contexts"

  ### VARIABLES ###
  # bd_map        = var.bd_map
  # l3out_map     = var.l3out_map
  srp_map       = var.srp_map
  device_map    = var.device_map
  contract_name = var.contract_name
  template_name = var.subject.service_graph.template_name
  # tenant_name   = var.subject.service_graph.tenant_name
  tenant_dn     = var.tenant.id
  logical_device_context = each.value

}
