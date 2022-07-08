output "filter_id" {
  value = local.filter.use_existing == true ? data.aci_filter.filter[0].id : aci_filter.filter[0].id #try(aci_filter.filter[0].id, data.aci_filter.filter[0].id)
}
