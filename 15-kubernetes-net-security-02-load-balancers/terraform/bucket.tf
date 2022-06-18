resource "yandex_storage_bucket" "netology-bucket" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  depends_on = [yandex_iam_service_account_static_access_key.sa-static-key]
  bucket     = "devops-10-netology-bucket"
  acl        = "public-read"
}

resource "yandex_storage_object" "cat" {
  access_key   = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key   = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  depends_on   = [yandex_iam_service_account_static_access_key.sa-static-key]
  bucket       = yandex_storage_bucket.netology-bucket.bucket
  key          = "cat.jpg"
  content_type = "image/jpeg"
  source       = "../imgs/cat.jpg"
  acl          = "public-read"
}