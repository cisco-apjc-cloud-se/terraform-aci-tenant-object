terraform {
  required_providers {
    aci = {
      source  = "CiscoDevNet/aci"
      version = ">=2.0.0"
    }
  }
  experiments = [module_variable_optional_attrs]
}

# locals {
#
# }

## Create L4-L7 Service Graph Template Connection ##
resource "aci_connection" "connection" {
    l4_l7_service_graph_template_dn = var.template_dn
    name                            = var.connection.connection_name # C2
    adj_type                        = var.connection.adj_type # "L3"
    description                     = var.connection.description # "from terraform"
    annotation                      = var.connection.annotation # "example"
    conn_dir                        = var.connection.conn_dir # "provider"
    conn_type                       = var.connection.conn_type # "external"
    direct_connect                  = var.connection.direct_connect # "no"
    name_alias                      = var.connection.name_alias # "example"
    unicast_route                   = var.connection.adj_type == "L3" ? "yes" : var.connection.unicast_route # "yes"
    # relation_vns_rs_abs_copy_connection
    # relation_vns_rs_abs_connection_conns = [
    #   ### Service Graph Template Cons/Prov DN ###
    #   var.template_conn_dn,
    #   ### Function Node Cons/Prov DN ###
    #   var.node_conn_dn
    # ]
    relation_vns_rs_abs_connection_conns = var.connection.dn_list
}
