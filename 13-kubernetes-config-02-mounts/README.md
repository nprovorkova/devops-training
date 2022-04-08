### 13.2 Разделы и монтирование - Наталия Проворкова
#### 1. Подключить для тестового конфига общую папку
```
В stage окружении часто возникает необходимость отдавать статику бекенда сразу фронтом. Проще всего сделать это через общую папку. Требования:

в поде подключена общая папка между контейнерами (например, /static);
после записи чего-либо в контейнере с беком файлы можно получить из контейнера с фронтом.
```
Deployment:
```yaml
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: monolit
  namespace: stage
spec:
  replicas: 2
  selector:
    matchLabels:
      app: monolit
  template:
    metadata:
      labels:
        app: monolit
    spec:
      containers:
      - image: provorkova/kubernetes-config_backend:latest
        name: back
        ports:
        - containerPort: 9000
        volumeMounts:
          - mountPath: "/static"
            name: static-volume
      - image: provorkova/kubernetes-config_frontend:latest
        name: front
        ports:
        - containerPort: 80
        volumeMounts:
          - mountPath: "/static"
            name: static-volume
      volumes:
      - name: static-volume
        emptyDir: {}
```
kubectl apply -f stage
<br>kubectl get pods -n stage
<br>kubectl exec monolit-75865874f8-f6tvf -n stage -c back -- /bin/bash -c 'echo "Hello, Front!" > /static/happy.txt'
<br>kubectl exec monolit-75865874f8-f6tvf -n stage -c back -- ls -la /static
<br>kubectl exec monolit-75865874f8-f6tvf -n stage -c front -- ls -la /static
<br>kubectl exec monolit-75865874f8-f6tvf -n stage -c front -- cat /static/happy.txt
<br>![stage](imgs/stage.png)
#### 2. Подключить общую папку для прода
```
Поработав на stage, доработки нужно отправить на прод. В продуктиве у нас контейнеры крутятся в разных подах, поэтому потребуется PV и связь через PVC. Сам PV должен быть связан с NFS сервером. Требования:

все бекенды подключаются к одному PV в режиме ReadWriteMany;
фронтенды тоже подключаются к этому же PV с таким же режимом;
файлы, созданные бекендом, должны быть доступны фронту.
```
<br>curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
<br>helm repo add stable https://charts.helm.sh/stable && helm repo update
<br>helm install nfs-server stable/nfs-server-provisioner
<br><b>На всех рабочих нодах устанавливаем nfs-common</b>
<br>sudo apt install nfs-common
<br>kubectl get sc
<br>kubectl get csinodes
<br>![prod-provisioners](imgs/prod-provisioners.png)
<br>PVC:
```yaml
---
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: common-pvc
  namespace: test-pvc
spec:
  storageClassName: "nfs"
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 2Gi
```
Бэк-Deployment:
```yaml
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: back
  namespace: test-pvc
spec:
  replicas: 2
  selector:
    matchLabels:
      app: back
  template:
    metadata:
      labels:
        app: back
    spec:
      containers:
      - image: provorkova/kubernetes-config_backend:latest
        name: back
        ports:
        - containerPort: 9000
        volumeMounts:
          - mountPath: "/static"
            name: common-volume
        env:
          - name: DATABASE_URL
            value: postgres://postgres:postgres@postgres-service:5432/news
      volumes:
        - name: common-volume
          persistentVolumeClaim:
            claimName: dynamic-pvc
```
Фронт-Deployment:
```yaml
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: front
  namespace: test-pvc
spec:
  replicas: 2
  selector:
    matchLabels:
      app: front
  template:
    metadata:
      labels:
        app: front
    spec:
      containers:
      - image: provorkova/kubernetes-config_frontend:latest
        name: front
        ports:
        - containerPort: 80
        volumeMounts:
          - mountPath: "/static"
            name: common-volume
        env:
          - name: BASE_URL
            value: http://back:9000
      volumes:
        - name: common-volume
          persistentVolumeClaim:
            claimName: dynamic-pvc
```
kubectl create namespace prod
<br>kubectl apply -f prod
<br>kubectl get sc
<br>kubectl get csinodes
<br>![prod-provisioners](imgs/prod-provisioners.png)
<br>kubectl get po,pvc,pv -n prod
<br>
<br>
<br>
<br>
<br>
<br>

