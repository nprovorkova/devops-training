### 14.4 Сервис-аккаунты - Наталия Проворкова
#### 1. Работа с сервис-аккаунтами через утилиту kubectl в установленном minikube
```
Как создать сервис-аккаунт?
kubectl create serviceaccount netology
```
![create](imgs/create.png)
```
Как просмотреть список сервис-акаунтов?
kubectl get serviceaccounts
kubectl get serviceaccount
```
![get-all-sa](imgs/get-all-sa.png)
```
Как получить информацию в формате YAML и/или JSON?
kubectl get serviceaccount netology -o yaml
kubectl get serviceaccount default -o json
```
![yaml-json](imgs/yaml-json.png)
```
Как выгрузить сервис-акаунты и сохранить его в файл?
kubectl get serviceaccounts -o json > serviceaccounts.json
kubectl get serviceaccount netology -o yaml > netology.yml
```
![export-json](imgs/export-json.png)
![export-yaml](imgs/export-yaml.png)  
```
Как удалить сервис-акаунт?
kubectl delete serviceaccount netology
```
![delete](imgs/delete.png) 
```
Как загрузить сервис-акаунт из файла?
kubectl apply -f netology.yml
```
![apply](imgs/apply.png) 
#### 2.(*) Работа с сервис-акаунтами внутри модуля
```
Выбрать любимый образ контейнера, подключить сервис-акаунты и проверить доступность API Kubernetes
kubectl run -n test-serviceaccount -i --tty fedora --image=fedora --restart=Never -- sh
```
![run](imgs/run.png) 
```
Просмотреть переменные среды
env | grep KUBE
```
![env](imgs/env.png)
```
Получить значения переменных
K8S=https://$KUBERNETES_SERVICE_HOST:$KUBERNETES_SERVICE_PORT
SADIR=/var/run/secrets/kubernetes.io/serviceaccount
TOKEN=$(cat $SADIR/token)
CACERT=$SADIR/ca.crt
NAMESPACE=$(cat $SADIR/namespace)
```
![set-vars](imgs/set-vars.png)
```
Подключаемся к API
curl -H "Authorization: Bearer $TOKEN" --cacert $CACERT $K8S/api/v1/
```
![curl](imgs/curl.png)
```
Подключаемся к API
curl -H "Authorization: Bearer $TOKEN" --cacert $CACERT $K8S/api/v1/
```
![curl](imgs/curl.png)
![curl-1](imgs/curl-1.png)
![curl-2](imgs/curl-2.png)
![curl-3](imgs/curl-3.png)
![curl-4](imgs/curl-4.png)
![curl-5](imgs/curl-5.png)
![curl-6](imgs/curl-6.png)
![curl-7](imgs/curl-7.png)
![curl-8](imgs/curl-8.png)
![curl-9](imgs/curl-9.png)
![curl-10](imgs/curl-10.png)
![curl-11](imgs/curl-11.png)
![curl-12](imgs/curl-12.png)
![curl-13](imgs/curl-13.png)
![curl-14](imgs/curl-14.png)
![curl-15](imgs/curl-15.png)