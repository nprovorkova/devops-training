### 13.4 инструменты для упрощения написания конфигурационных файлов. Helm и Jsonnet - Наталия Проворкова
#### 1. Подготовить helm чарт для приложения
```
Необходимо упаковать приложение в чарт для деплоя в разные окружения. Требования:

каждый компонент приложения деплоится отдельным deployment’ом/statefulset’ом;
в переменных чарта измените образ приложения для изменения версии.
```
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
<br>chmod 700 get_helm.sh
<br>./get_helm.sh
<br>templates:
```yaml
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ .Values.backName }}
  namespace: {{ .Values.namespace }}
spec:
  replicas: 2
  selector:
    matchLabels:
      app: {{ .Values.backName }}
  template:
    metadata:
      labels:
        app: {{ .Values.backName }}
    spec:
      containers:
      - image: {{ .Values.backImage }}:{{ .Values.backImageTag }}
        name: {{ .Values.backName }}
        ports:
        - containerPort: {{ .Values.backPort }}
        volumeMounts:
          - mountPath: "/dynamic"
            name: dynamic-volume
        env:
          - name: DATABASE_URL
            value: postgres://postgres:postgres@postgres-service:5432/news
      volumes:
        - name: dynamic-volume
          persistentVolumeClaim:
            claimName: dynamic-pvc
---
apiVersion: v1
kind: Service
metadata:
  name: back-service
  namespace: {{ .Values.namespace }}
spec:
  type: ClusterIP
  selector:
    app: {{ .Values.backName }}
  ports:
    - port: {{ .Values.backPort }}
      targetPort: {{ .Values.backPort }}
      protocol: TCP
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ .Values.frontName }}
  namespace: {{ .Values.namespace }}
spec:
  replicas: 2
  selector:
    matchLabels:
      app: {{ .Values.frontName }}
  template:
    metadata:
      labels:
        app: {{ .Values.frontName }}
    spec:
      containers:
      - image: {{ .Values.frontImage }}:{{ .Values.frontImageTag }}
        name: {{ .Values.frontName }}
        ports:
        - containerPort: 80
        volumeMounts:
          - mountPath: "/dynamic"
            name: dynamic-volume
        env:
          - name: BASE_URL
            value: http://{{ .Values.backName }}:{{ .Values.backPort }}
      volumes:
        - name: dynamic-volume
          persistentVolumeClaim:
            claimName: dynamic-pvc
---
apiVersion: v1
kind: Service
metadata:
  name: front-service
  namespace: {{ .Values.namespace }}
spec:
  type: ClusterIP
  selector:
    app: {{ .Values.frontName }}
  ports:
    - port: {{ .Values.frontPort }}
      targetPort: 80
      protocol: TCP
---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: {{ .Values.postgresName }}
  namespace: {{ .Values.namespace }}
spec:
  serviceName: postgres-service
  replicas: 1
  selector:
    matchLabels:
      app: {{ .Values.postgresName }}
  template:
    metadata:
      labels:
        app: {{ .Values.postgresName }}
    spec:
      containers:
        - name: {{ .Values.postgresName }}
          image: {{ .Values.postgresImage }}:{{ .Values.postgresImageTag }}
          env:
            - name: POSTGRES_PASSWORD
              value: postgres
            - name: POSTGRES_USER
              value: postgres
            - name: POSTGRES_DB
              value: news
          volumeMounts:
            - name: postgres-volume
              mountPath: /var/lib/postgresql/data/
      volumes:
        - name: postgres-volume
---
apiVersion: v1
kind: Service
metadata:
  name: postgres-service
  namespace: {{ .Values.namespace }}
spec:
  type: ClusterIP
  selector:
    app: postgres
  ports:
    - port: {{ .Values.postgresPort }}
      targetPort: {{ .Values.postgresPort }}
      protocol: TCP
---
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: dynamic-pvc
  namespace: {{ .Values.namespace }}
spec:
  storageClassName: nfs
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 2Gi
```
Chart:
```yaml
apiVersion: v2
name: project-chart
description: Chart for phyton-application

type: application

version: 0.1.1
appVersion: "0.1.1"
```
values:
```yaml
namespace: prod

backName: back
backPort: 9000
backImage: provorkova/kubernetes-config_backend
backImageTag: latest

frontName: front
frontPort: 8000
frontImage: provorkova/kubernetes-config_frontend
frontImageTag: latest

postgresName: postgres
postgresPort: 5432
postgresImage: postgres
postgresImageTag: 13-alpine
```
#### 2. Запустить 2 версии в разных неймспейсах
```
Подготовив чарт, необходимо его проверить. Попробуйте запустить несколько копий приложения:

одну версию в namespace=app1;
вторую версию в том же неймспейсе;
третью версию в namespace=app2.
```
helm lint project-chart
<br>kubectl create namespace app1
<br>helm install first-release project-chart --set namespace=app1
<br>![app1](imgs/app1.png)
<br>helm upgrade first-release project-chart --set namespace=app1 --set version=0.1.2
<br>Попытки обновить версию в том же неймспейсе проваливаются: версия остается прежней
<br>![app1-new-versions-failed](imgs/app1-new-versions-failed.png)
<br>kubectl create namespace app2
<br>helm install third-release project-chart --set namespace=app2 --set version=0.1.3
<br>![app2](imgs/app2.png)