terraform {
  required_providers {
    aci = {
      source  = "CiscoDevNet/aci"
      version = ">=2.0.0"
    }
    time = {
      source = "hashicorp/time"
      version = "0.7.2"
    }
  }
  experiments = [module_variable_optional_attrs]
}

### Load existing Device ###
data "aci_tenant" "tenant" {
  count = var.logical_device_context.device.tenant_name != null ? 1 : 0

  name = var.logical_device_context.device.tenant_name
}

data "aci_l4_l7_device" "device" {
  count = var.logical_device_context.device.tenant_name != null ? 1 : 0

  tenant_dn        = data.aci_tenant.tenant[0].id
  name             = var.logical_device_context.device.device_name
}

### ACI L4-L7 Service Graph Instance - Logical Device Context ###
resource "aci_logical_device_context" "node" {
  tenant_dn         = var.tenant_dn
  ctrct_name_or_lbl = var.contract_name
  graph_name_or_lbl = var.template_name
  node_name_or_lbl  = var.logical_device_context.node_name
  annotation        = var.logical_device_context.annotation
  description       = var.logical_device_context.description
  context           = var.logical_device_context.context
  name_alias        = var.logical_device_context.name_alias

  relation_vns_rs_l_dev_ctx_to_l_dev = var.logical_device_context.device.tenant_name != null ? data.aci_l4_l7_device.device[0].id : var.device_map[var.logical_device_context.device.device_name].id # "uni/tn-test_acc_tenant/lDevVip-LoadBalancer01"
}

### ACI L4-L7 Service Graph Instance - Consumer Interface Context ###
module "consumer_interface" {
  source = "./modules/logical_interface_contexts"

  ### VARIABLES ###
  # bd_map                    = var.bd_map
  # l3out_map                 = var.l3out_map
  srp_map                   = var.srp_map
  tenant_dn                 = var.tenant_dn
  logical_device_context_dn = aci_logical_device_context.node.id
  logical_int_map           = var.device_map[var.logical_device_context.device.device_name].logical_int_map
  interface = {
    type                = var.logical_device_context.consumer_interface.type
    conn_name           = var.logical_device_context.consumer_interface.conn_name
    cluster_interface   = var.logical_device_context.consumer_interface.cluster_interface
    l3_dest             = var.logical_device_context.consumer_interface.l3_dest
    redirect_policy     = var.logical_device_context.consumer_interface.redirect_policy
    service_epg_policy  = var.logical_device_context.consumer_interface.service_epg_policy
    annotation          = var.logical_device_context.consumer_interface.annotation
    description         = var.logical_device_context.consumer_interface.description
    name_alias          = var.logical_device_context.consumer_interface.name_alias
    permit_log          = var.logical_device_context.consumer_interface.permit_log
    bd                  = var.logical_device_context.consumer_interface.bd
    extepg              = var.logical_device_context.consumer_interface.extepg
  }
}

### ACI L4-L7 Service Graph Instance - Provider Interface Context ###
module "provider_interface" {
  source = "./modules/logical_interface_contexts"

  ### VARIABLES ###
  # bd_map                    = var.bd_map
  # l3out_map                 = var.l3out_map
  srp_map                   = var.srp_map
  tenant_dn                 = var.tenant_dn
  logical_device_context_dn = aci_logical_device_context.node.id
  logical_int_map           = var.device_map[var.logical_device_context.device.device_name].logical_int_map
  interface = {
    type                = var.logical_device_context.provider_interface.type
    conn_name           = var.logical_device_context.provider_interface.conn_name
    cluster_interface   = var.logical_device_context.provider_interface.cluster_interface
    l3_dest             = var.logical_device_context.provider_interface.l3_dest
    redirect_policy     = var.logical_device_context.provider_interface.redirect_policy
    service_epg_policy  = var.logical_device_context.provider_interface.service_epg_policy
    annotation          = var.logical_device_context.provider_interface.annotation
    description         = var.logical_device_context.provider_interface.description
    name_alias          = var.logical_device_context.provider_interface.name_alias
    permit_log          = var.logical_device_context.provider_interface.permit_log
    bd                  = var.logical_device_context.provider_interface.bd
    extepg              = var.logical_device_context.provider_interface.extepg
  }
}
