output "public_network_vm_ip" {
  value = yandex_compute_instance.public-network-vm.network_interface.0.nat_ip_address
}

output "private_network_vm_ip" {
  value = yandex_compute_instance.private-network-vm.network_interface.0.ip_address
}