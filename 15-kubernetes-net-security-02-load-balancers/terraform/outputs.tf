output "network_balancer_ip" {
  value = yandex_lb_network_load_balancer.lamp.listener.*.external_address_spec[*].*.address
}