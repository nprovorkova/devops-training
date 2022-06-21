resource "yandex_vpc_subnet" "public" {
  for_each = local.zones_k8s
  zone           = each.value.zone_name
  network_id     = yandex_vpc_network.vpc-0.id
  v4_cidr_blocks = each.value.public_subnet
}

resource "yandex_vpc_subnet" "private" {
  for_each = local.zones
  zone           = each.value.zone_name
  network_id     = yandex_vpc_network.vpc-0.id
  v4_cidr_blocks = each.value.private_subnet
}

resource "yandex_vpc_subnet" "private_k8s" {
  for_each = local.zones_k8s
  zone           = each.value.zone_name
  network_id     = yandex_vpc_network.vpc-0.id
  v4_cidr_blocks = each.value.private_subnet
}