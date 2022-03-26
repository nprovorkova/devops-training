### 12.4 Развертывание кластера на собственных серверах, лекция 2 - Наталия Проворкова
#### 1. Подготовить инвентарь kubespray
```
Новые тестовые кластеры требуют типичных простых настроек. Нужно подготовить инвентарь и проверить его работу. Требования к инвентарю:

подготовка работы кластера из 5 нод: 1 мастер и 4 рабочие ноды;
в качестве CRI — containerd;
запуск etcd производить на мастере.
```
Так как под рукой нет ресурсов для запуска вагранта, приняла решение поднять виртуалку с Ubuntu в облаке, на ней запускать KubeSpray и развернуть кластер.
<br>ssh  user@51.250.102.171 - адрес вспомогательной ВМ
<br>sudo apt-get update 
<br>sudo apt-get install git
<br>git clone https://github.com/kubernetes-sigs/kubespray
<br>sudo apt-get -y install python3-pip
<br>cd kubespray
<br>sudo pip3 install -r requirements.txt
<br>whoami
<br>ssh-keygen
<br>cat ~/.ssh/id_rsa.pub
<br>cp -rfp inventory/sample inventory/happy-cluster
<br>cd inventory/happy-cluster
<br><br>ssh 51.250.102.220 -cp
<br>ssh 51.250.103.49 - worker1
<br>ssh 51.250.97.112 -worker2
<br>[inventory.ini](inventory/happy-cluster/deployment.yaml)
<br>В k8s-cluster.yml устанавливаем 
```
container_manager: containerd
kube_api_anonymous_auth: false
kube_basic_auth: true
kube_apiserver_insecure_port: 8080

```
<br>В containerd.yml
```
containerd_registries:
  "docker.io":
    - "https://hub.docker.com"
    - "https://k8s.gcr.io"
```
<br>В all.yml
```
loadbalancer_apiserver:
  address: 51.250.102.220
  port: 6443
```
<br>/roles/kubernetes/node/tasks/main.yml
```
Change all occurrence of “nf_conntrack_ipv4” To “nf_conntrack”
```
<br>ansible-playbook --flush-cache -i inventory/happy-cluster/inventory.ini cluster.yml -b -v -e ansible_user=user

<br>Заходим на мастер-ноду
<br>kubectl get nodes

