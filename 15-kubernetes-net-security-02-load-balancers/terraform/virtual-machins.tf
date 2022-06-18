resource "yandex_compute_instance_group" "LAMP" {
  name               = "lamp"
  folder_id          = yandex_iam_service_account.service-account-0.folder_id
  service_account_id = yandex_iam_service_account.service-account-0.id
  depends_on         = [yandex_resourcemanager_folder_iam_member.sa-editor]

  instance_template {
    resources {
      memory = 2
      cores  = 2
    }

    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = local.lamp_image_id
      }
    }

    network_interface {
      subnet_ids = [yandex_vpc_subnet.public.id]
      nat        = true
    }

    metadata = {
      ssh-keys  = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
      user-data = <<EOF
#!/bin/sh
PICURL="https://storage.yandexcloud.net/${yandex_storage_bucket.netology-bucket.bucket}/${yandex_storage_object.cat.key}"
cd /var/www/html
echo "<html><body><img src='$PICURL'></body></html>" > index.html
EOF
    }
  }

  scale_policy {
    fixed_scale {
      size = 3
    }
  }

  allocation_policy {
    zones = [local.zone]
  }

  deploy_policy {
    max_unavailable = 1
    max_expansion   = 0
  }

  health_check {
    interval            = 10
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 6
    http_options {
      port = 80
      path = "/"
    }
  }
}
