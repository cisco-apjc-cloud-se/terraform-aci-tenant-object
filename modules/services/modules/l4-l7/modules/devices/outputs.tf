output "device_id" {
  value = aci_l4_l7_device.device.id
}

output "logical_int_map" {
  value = local.logical_int_map
}
