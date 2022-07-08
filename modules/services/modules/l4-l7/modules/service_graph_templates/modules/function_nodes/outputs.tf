output "node_id" {
  value = aci_function_node.node.id
}

# conn_consumer_dn - Dn of consumer connection in fuction node.
# conn_provider_dn - Dn of provider connection in fuction node.

output "conn_consumer_dn" {
  value = aci_function_node.node.conn_consumer_dn
}

output "conn_provider_dn" {
  value = aci_function_node.node.conn_provider_dn
}
