### 14.1 Создание и использование секретов - Наталия Проворкова
#### 1. Работа с секретами через утилиту kubectl в установленном minikube
```
Как создать секрет?

openssl genrsa -out cert.key 4096
openssl req -x509 -new -key cert.key -days 3650 -out cert.crt \
-subj '/C=RU/ST=Moscow/L=Moscow/CN=server.local'
kubectl create secret tls domain-cert --cert=certs/cert.crt --key=certs/cert.key
```
![create](imgs/create.png)
```
Как просмотреть список секретов?
kubectl get secrets
kubectl get secret
```
![get-all-secrets](imgs/get-all-secrets.png)
```
Как просмотреть секрет?
kubectl get secret domain-cert
kubectl describe secret domain-cert
```
![get](imgs/get.png)
```
Как получить информацию в формате YAML и/или JSON?
kubectl get secret domain-cert -o yaml
kubectl get secret domain-cert -o json
```
![yaml-1](imgs/yaml-1.png)
![yaml-2](imgs/yaml-2.png)
![json-1](imgs/json-1.png)
![json-2](imgs/json-2.png)
```
Как выгрузить секрет и сохранить его в файл?
kubectl get secrets -o json > secrets.json
kubectl get secret domain-cert -o yaml > domain-cert.yml
```
![export-yaml](imgs/export-yaml.png) 
![export-json](imgs/export-json.png) 
```
Как удалить секрет?
kubectl delete secret domain-cert
```
![delete](imgs/delete.png) 
```
Как загрузить секрет из файла?
kubectl apply -f domain-cert.yml
```
![from-file](imgs/from-file.png) 