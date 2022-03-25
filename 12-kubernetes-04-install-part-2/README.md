### 12.4 Развертывание кластера на собственных серверах, лекция 2 - Наталия Проворкова
#### 1. Подготовить инвентарь kubespray
```
Новые тестовые кластеры требуют типичных простых настроек. Нужно подготовить инвентарь и проверить его работу. Требования к инвентарю:

подготовка работы кластера из 5 нод: 1 мастер и 4 рабочие ноды;
в качестве CRI — containerd;
запуск etcd производить на мастере.
```
sudo service ssh start
<br>whoami
<br>cat /home/nataliya/.ssh/id_rsa.pub
<br>chmod 400 ~/.ssh/id_rsa
<br>ssh 51.250.21.216 - Control-Plane
<br>ssh 51.250.18.192 - Worker1
<br>ssh 51.250.31.79 - Worker2
<br>[inventory.ini](inventory/happy-cluster/deployment.yaml)
<br>В k8s-cluster.yml устанавливаем 
```
container_manager: containerd
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
  address: 51.250.105.102
  port: 6443
```
<br>export ANSIBLE_CONFIG=./ansible.cfg
<br>ansible-playbook -i inventory/happy-cluster/inventory.ini cluster.yml -b -v -e ansible_user=nataliya

<br>Заходим на мастер-ноду
<br>kubectl get nodes

