resource "yandex_lb_target_group" "lamp" {
  name = "lamp"

  dynamic "target" {
    for_each = yandex_compute_instance_group.LAMP.instances
    content {
      subnet_id = target.value.network_interface.0.subnet_id
      address   = target.value.network_interface.0.ip_address
    }
  }
}

resource "yandex_lb_network_load_balancer" "lamp" {
  name = "lamp-load-balancer"

  listener {
    name = "http-listener"
    port = 80
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_lb_target_group.lamp.id

    healthcheck {
      name                = "http"
      timeout             = 1
      healthy_threshold   = 3
      unhealthy_threshold = 4
      http_options {
        port = 80
        path = "/"
      }
    }
  }
}