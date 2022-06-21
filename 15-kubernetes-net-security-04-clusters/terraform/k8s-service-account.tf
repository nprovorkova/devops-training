resource "yandex_iam_service_account" "service-account-0" {
  name = "netology-service-account"
}

resource "yandex_resourcemanager_folder_iam_member" "sa-editor" {
  folder_id  = yandex_iam_service_account.service-account-0.folder_id
  role       = "editor"
  member     = "serviceAccount:${yandex_iam_service_account.service-account-0.id}"
  depends_on = [yandex_iam_service_account.service-account-0]
}

resource "yandex_resourcemanager_folder_iam_member" "sa-images-puller" {
  folder_id  = yandex_iam_service_account.service-account-0.folder_id
  role       = "container-registry.images.puller"
  member     = "serviceAccount:${yandex_iam_service_account.service-account-0.id}"
  depends_on = [yandex_iam_service_account.service-account-0]
}

resource "yandex_kms_symmetric_key" "k8s-key" {
  name = "k8s-key"
}