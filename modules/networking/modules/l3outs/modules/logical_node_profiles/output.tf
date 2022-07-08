output "lprof_id" {
  value = local.logical_node_profile.use_existing == true ? data.aci_logical_node_profile.lprof[0].id : aci_logical_node_profile.lprof[0].id #try(aci_logical_node_profile.lprof[0].id, data.aci_logical_node_profile.lprof[0].id)
}
