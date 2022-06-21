resource "yandex_kubernetes_node_group" "netology-cluster-workers" {
  for_each = local.zones_k8s
  cluster_id  = yandex_kubernetes_cluster.netology-control-plane.id
  name        = "netology-cluster-nodegroup-${each.key}"
  version     = local.k8s.version

  instance_template {
    platform_id = "standard-v2"

    network_interface {
      nat                = true
      subnet_ids         = [yandex_vpc_subnet.public[each.key].id]
    }

    resources {
      memory = 2
      cores  = 2
    }

    boot_disk {
      type = "network-ssd-nonreplicated"
      size = 93
    }

    scheduling_policy {
      preemptible = true
    }

    container_runtime {
      type = "containerd"
    }

    metadata = {
      ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
    }
  }

  scale_policy {
    auto_scale {
      min = 1
      max = 2
      initial = 1
    }
  }

  allocation_policy {
    location {
      zone = each.value.zone_name
    }
  }
}
