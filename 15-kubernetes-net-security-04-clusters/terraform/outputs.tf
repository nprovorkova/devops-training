output "kubeconfig" {
  value = <<KUBECONFIG
apiVersion: v1
clusters:
- cluster:
    server: ${yandex_kubernetes_cluster.netology-control-plane.master[0].external_v4_endpoint}
    certificate-authority-data: ${base64encode(yandex_kubernetes_cluster.netology-control-plane.master[0].cluster_ca_certificate)}
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: ${yandex_iam_service_account.service-account-0.name}
  name: ycmk8s
current-context: ycmk8s
users:
- name: ${yandex_iam_service_account.service-account-0.name}
  user:
    exec:
      command: yc
      apiVersion: client.authentication.k8s.io/v1beta1
      interactiveMode: Never
      args:
      - k8s
      - create-token
KUBECONFIG
}