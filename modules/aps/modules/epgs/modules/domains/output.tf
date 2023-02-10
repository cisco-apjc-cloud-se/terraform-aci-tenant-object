output "dpg_id" {
  value = var.domain.type == "vmware" ? aci_epg_to_domain.vmware[0].id : null
}

output "dpg_name" {
  value = var.domain.type == "vmware" ? format("%s|%s|%s", var.tenant_name, var.ap_name, var.epg_name ) : null
}
