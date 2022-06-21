resource "yandex_mdb_mysql_cluster" "netology-mysql-db" {
  name        = "netology-mysql-db"
  environment = "PRESTABLE"
  network_id  = yandex_vpc_network.vpc-0.id
  version     = "8.0"

  resources {
    resource_preset_id = "b1.medium"
    disk_type_id       = "network-ssd"
    disk_size          = 20
  }

  maintenance_window {
    type = "ANYTIME"
  }

  backup_window_start {
    hours   = 23
    minutes = 59
  }

  deletion_protection = true

  database {
    name = local.db.name
  }

  user {
    name     = local.db.user
    password = local.db.password
    permission {
      database_name = local.db.name
      roles         = ["ALL"]
    }
  }

  dynamic "host" {
    for_each = local.zones
    content {
      zone      = host.value.zone_name
      subnet_id = yandex_vpc_subnet.private[host.key].id
      name      = "db-host-${host.key}"
    }
  }
}