output "vm_dev_name" {
  value = yandex_compute_instance.sausage-store-dev-vm.name
}

output "vm_dev_address" {
  value = yandex_compute_instance.sausage-store-dev-vm.network_interface.0.nat_ip_address
}

output "vm_prod_name" {
  value = yandex_compute_instance.sausage-store-vm-prod.name
}

output "vm_prod_address" {
  value = yandex_compute_instance.sausage-store-vm-prod.network_interface.0.nat_ip_address
}