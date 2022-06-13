resource "yandex_vpc_route_table" "private_route_table" {
  network_id = yandex_vpc_network.vpc-0.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = local.nat_gateway
  }
}