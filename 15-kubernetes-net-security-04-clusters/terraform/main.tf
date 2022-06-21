terraform {
  required_version = ">= 1.0.0"

  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  cloud_id  = "b1g3s8lnqjnl4svbgr1b"
  folder_id = "b1gg1276n3b2qlltke1k"
  zone      = local.zones.central_b.zone_name
}

locals {
  zones = {
    central_a = {
      zone_name      = "ru-central1-a"
      private_subnet = ["192.168.20.0/24"]
    }
    central_b = {
      zone_name      = "ru-central1-b"
      private_subnet = ["192.168.21.0/24"]
    }
    central_c = {
      zone_name      = "ru-central1-c"
      private_subnet = ["192.168.22.0/24"]
    }
  }

  zones_k8s = {
    a = {
      zone_name      = "ru-central1-a"
      public_subnet  = ["192.168.10.0/24"]
      private_subnet = ["192.168.50.0/24"]
    }
    b = {
      zone_name      = "ru-central1-b"
      public_subnet  = ["192.168.11.0/24"]
      private_subnet = ["192.168.51.0/24"]
    }
    c = {
      zone_name      = "ru-central1-c"
      public_subnet  = ["192.168.12.0/24"]
      private_subnet = ["192.168.52.0/24"]
    }
  }

  db = {
    name     = "netology_db"
    user     = "netology"
    password = "ntlg13579!"
  }

  k8s = {
    region  = "ru-central1"
    version = "1.21"
  }
}