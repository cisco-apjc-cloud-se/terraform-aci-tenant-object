terraform {
  required_providers {
    aci = {
      source  = "CiscoDevNet/aci"
      version = ">=2.0.0"
    }
  }
  experiments = [module_variable_optional_attrs]
}

resource "aci_l4_l7_service_graph_template" "template" {
  tenant_dn                         = var.tenant.id
  name                              = var.service_graph_template.template_name
  annotation                        = var.service_graph_template.annotation
  name_alias                        = var.service_graph_template.name_alias
  description                       = var.service_graph_template.description
  l4_l7_service_graph_template_type = var.service_graph_template.l4_l7_service_graph_template_type # Allowed values are "legacy" and "cloud". Default value is "legacy".
  # "ONE_NODE_ADC_ONE_ARM_L3EXT"
  # "ONE_NODE_ADC_TWO_ARM"
  # "ONE_NODE_FW_ROUTED"
  # "ONE_NODE_FW_TRANS"
  # "TWO_NODE_FW_ROUTED_ADC_ONE_ARM"
  # "TWO_NODE_FW_ROUTED_ADC_ONE_ARM_L3EXT"
  # "TWO_NODE_FW_ROUTED_ADC_TWO_ARM"
  # "TWO_NODE_FW_TRANS_ADC_ONE_ARM"
  # "TWO_NODE_FW_TRANS_ADC_ONE_ARM_L3EXT"
  # "TWO_NODE_FW_TRANS_ADC_TWO_ARM"
  # "UNSPECIFIED". Default value is "UNSPECIFIED".
  ui_template_type                  = upper(var.service_graph_template.ui_template_type) #"ONE_NODE_ADC_ONE_ARM"
  term_prov_name                    = var.service_graph_template.term_prov_name
  term_cons_name                    = var.service_graph_template.term_cons_name
}

### ACI L4-7 Service Graph Template Function Nodes Module ###
module "function_nodes" {
  for_each = var.service_graph_template.function_nodes
  source = "./modules/function_nodes"

  ### VARIABLES ###
  template_dn = aci_l4_l7_service_graph_template.template.id
  node        = each.value
  device_map  = var.device_map
}

### ACI L4-7 Service Graph Template Connections Module ###
### NOTE: Need Connections between Consumer <-> Node(s) <-> Provider

locals {
  function_map = {
    for k,n in var.service_graph_template.function_nodes:
      k => {
        id               = module.function_nodes[k].node_id
        name             = n.node_name
        conn_consumer_dn = module.function_nodes[k].conn_consumer_dn
        conn_provider_dn = module.function_nodes[k].conn_provider_dn
        sequence_number  = n.sequence_number
      }
    }
  node_count = length(var.service_graph_template.function_nodes)
  node_seq_list = range(2, (local.node_count + 1)) # [2,3..]

  first_node = {
    for k,n in local.function_map :
      k => n
    if n.sequence_number == 1
    }
  last_node = {
    for k,n in local.function_map :
      k => n
    if n.sequence_number == local.node_count
  }

  intermediate_connections = {
    for num in local.node_seq_list :
      "node-${num - 1}-to-(${num})" => {
        first_node = {
          for k,n in local.function_map :
            k => n
          if n.sequence_number == (num - 1)
        }
        next_node = {
          for k,n in local.function_map :
            k => n
          if n.sequence_number == num
        }
      }
  }

}

module "first_connection" {
  for_each = local.first_node
  source = "./modules/connections"

  ### VARIABLES ###
  template_dn   = aci_l4_l7_service_graph_template.template.id
  connection  = {
    connection_name = format("Consumer-to-%s", title(each.value.name))
    adj_type        = "L3" # Allowed values are "L2", "L3". Default value is "L2"
    description     = format("Connection from consumer to %s node", title(each.value.name))
    conn_dir        = "provider" # Allowed values are "consumer", "provider". Default value is "provider".
    conn_type       = "internal" # Allowed values are "external", "internal". Default value is "external".
    dn_list         = [
      aci_l4_l7_service_graph_template.template.term_cons_dn,
      each.value.conn_consumer_dn
    ]
  }
}

module "last_connection" {
  for_each = local.last_node
  source = "./modules/connections"

  ### VARIABLES ###
  template_dn   = aci_l4_l7_service_graph_template.template.id
  connection  = {
    connection_name = format("%s-to-Provider", title(each.value.name))
    adj_type        = "L3" # Allowed values are "L2", "L3". Default value is "L2"
    description     = format("Connection from %s node to provider", title(each.value.name))
    conn_dir        = "provider" # Allowed values are "consumer", "provider". Default value is "provider".
    conn_type       = "internal" # Allowed values are "external", "internal". Default value is "external".
    dn_list         = [
      aci_l4_l7_service_graph_template.template.term_prov_dn,
      each.value.conn_provider_dn
    ]
  }
}

module "intermediate_connections" {
  for_each = local.intermediate_connections
  source = "./modules/connections"

  ### VARIABLES ###
  template_dn   = aci_l4_l7_service_graph_template.template.id
  connection  = {
    connection_name = format("%s-to-%s", title(each.value.first_node.name), title(each.value.next_node.name))
    adj_type        = "L3" # Allowed values are "L2", "L3". Default value is "L2"
    description     = format("Connection from %s node to %s", title(each.value.first_node.name), title(each.value.next_node.name))
    conn_dir        = "provider" # Allowed values are "consumer", "provider". Default value is "provider".
    conn_type       = "internal" # Allowed values are "external", "internal". Default value is "external".
    dn_list         = [
      each.value.first_node.conn_provider_dn,
      each.value.next_node.conn_consumer_dn
    ]
  }
}
