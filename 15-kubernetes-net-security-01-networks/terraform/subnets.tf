resource "yandex_vpc_subnet" "public" {
  zone           = local.zone
  network_id     = yandex_vpc_network.vpc-0.id
  v4_cidr_blocks = [local.public_subnet]
}

resource "yandex_vpc_subnet" "private" {
  zone           = local.zone
  network_id     = yandex_vpc_network.vpc-0.id
  v4_cidr_blocks = [local.private_subnet]
  route_table_id = yandex_vpc_route_table.private_route_table.id
}