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
  zone      = local.zone
}

locals {
  zone           = "ru-central1-b"
  public_subnet  = "192.168.10.0/24"
  private_subnet = "192.168.20.0/24"
  nat_image_id   = "fd80mrhj8fl2oe87o4e1"
  nat_gateway    = "192.168.10.254"
}