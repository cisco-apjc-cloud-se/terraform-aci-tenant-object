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
  device_id = var.node.device.tenant_name != null ? data.aci_l4_l7_device.device[0].id : var.device_map[var.node.device.device_name].id
}

### Load existing Tenant for External device ###
data "aci_tenant" "tenant" {
  count = var.node.device.tenant_name != null ? 1 : 0

  name = var.node.device.tenant_name
}

### Load existing External device ###
data "aci_l4_l7_device" "device" {
  count = var.node.device.tenant_name != null ? 1 : 0

  tenant_dn = data.aci_tenant.tenant[0].id
  name      = var.node.device.device_name
}

resource "aci_function_node" "node" {
  l4_l7_service_graph_template_dn = var.template_dn
  name                            = var.node.node_name
  annotation                      = var.node.annotation
  description                     = var.node.description
  # "OTHER"
  # "FW_TRANS"
  # "FW_ROUTED"
  # "CLOUD_VENDOR_LB"
  # "CLOUD_VENDOR_FW"
  # "CLOUD_NATIVE_LB"
  # "CLOUD_NATIVE_FW"
  # "ADC_TWO_ARM"
  # "ADC_ONE_ARM"
  func_template_type              = upper(var.node.func_template_type) # Default value: "OTHER".
  func_type                       = var.node.func_type # Allowed values: "GoThrough", "GoTo", "L1", "L2", "None". Default value: "GoTo".
  is_copy                         = var.node.is_copy # Default value: "no".
  managed                         = var.node.managed == null ? "no" : var.node.managed # Default value: "no" (NOTE: seems to default to yes so overriden)
  name_alias                      = var.node.name_alias
  routing_mode                    = var.node.routing_mode  # Allowed values: "Redirect", "unspecified". Default value: "unspecified".
  sequence_number                 = var.node.sequence_number # "1"
  share_encap                     = var.node.share_encap # Allowed values: "yes", "no". Default value: "no".

  ### Mapping to Device ###
  relation_vns_rs_node_to_l_dev   = local.device_id
}
