resource "yandex_kubernetes_cluster" "netology-control-plane" {
  name       = "netology-control-plane"
  network_id = yandex_vpc_network.vpc-0.id

  master {
    regional {
      region = local.k8s.region

      dynamic "location" {
        for_each = local.zones_k8s
        content {
          zone      = yandex_vpc_subnet.public[location.key].zone
          subnet_id = yandex_vpc_subnet.public[location.key].id
        }
      }
    }

    version   = local.k8s.version
    public_ip = true
  }

  service_account_id      = yandex_iam_service_account.service-account-0.id
  node_service_account_id = yandex_iam_service_account.service-account-0.id
  depends_on = [
    yandex_vpc_network.vpc-0,
    yandex_vpc_subnet.public,
    yandex_iam_service_account.service-account-0,
    yandex_resourcemanager_folder_iam_member.sa-editor,
    yandex_resourcemanager_folder_iam_member.sa-images-puller,
    yandex_kms_symmetric_key.k8s-key
  ]

  release_channel = "STABLE"

  kms_provider {
    key_id = yandex_kms_symmetric_key.k8s-key.id
  }
}