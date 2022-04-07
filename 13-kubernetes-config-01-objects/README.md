### 13.1 Контейнеры, поды, deployment, statefulset, services, endpoints - Наталия Проворкова
#### 1. Подготовить тестовый конфиг для запуска приложения
```
Для начала следует подготовить запуск приложения в stage окружении с простыми настройками. Требования:

под содержит в себе 2 контейнера — фронтенд, бекенд;
регулируется с помощью deployment фронтенд и бекенд;
база данных — через statefulset.
https://github.com/netology-code/devkub-homeworks/tree/main/13-kubernetes-config
```
Собираем проект локально и пушим образ на dockerhub
<br>docker-compose up --build
<br>docker images
<br>docker login
<br>docker tag 13-kubernetes-config_frontend:latest provorkova/kubernetes-config_frontend:latest
<br>docker tag 13-kubernetes-config_backend:latest provorkova/kubernetes-config_backend:latest
<br>docker push provorkova/kubernetes-config_frontend:latest
<br>docker push provorkova/kubernetes-config_backend:latest
<br><br>Создаем Манифесты для stage-окружения
<br>Deployment:
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
      - image: provorkova/kubernetes-config_frontend:latest
        name: front
        ports:
        - containerPort: 80
```
StatefulSet:
```yaml
---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: postgresql
  namespace: stage
spec:
  serviceName: postgres-service
  replicas: 1
  selector:
    matchLabels:
      app: postgresql
  template:
    metadata:
      labels:
        app: postgresql
    spec:
      containers:
        - name: postgresql
          image: postgres:13-alpine
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
```
Services:
```yaml
---
apiVersion: v1
kind: Service
metadata:
  name: postgres-service
  namespace: stage
spec:
  type: ClusterIP
  selector:
    app: postgresql
  ports:
    - port: 5432
      targetPort: 5432
      protocol: TCP
---
apiVersion: v1
kind: Service
metadata:
  name: inner-stage
  namespace: stage
spec:
  ports:
    - name: web
      port: 80
      protocol: TCP
    - name: api
      port: 9000
      protocol: TCP
  selector:
    app: monolit
  type: ClusterIP
```
kubectl create namespace stage
<br>kubectl apply -f stage
<br>![stage-entities](imgs/stage-entities.png)
<br>kubectl port-forward -n stage service/inner-stage 8080:80 
<br>![stage-curl](imgs/stage-curl.png)
#### 2. Подготовить конфиг для production окружения
```
Следующим шагом будет запуск приложения в production окружении. Требования сложнее:

каждый компонент (база, бекенд, фронтенд) запускаются в своем поде, регулируются отдельными deployment’ами;
для связи используются service (у каждого компонента свой);
в окружении фронта прописан адрес сервиса бекенда;
в окружении бекенда прописан адрес сервиса базы данных.
```
Создаем манифесты для прод-окружения
Бэк-Deployment:
```yaml
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: back
  namespace: prod
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
          env:
            - name: DATABASE_URL
              value: postgres://postgres:postgres@postgres-service:5432/news
```
Бэк-Service:
```yaml
---
apiVersion: v1
kind: Service
metadata:
  name: back-service
  namespace: prod
spec:
  type: ClusterIP
  selector:
    app: back
  ports:
    - port: 9000
      targetPort: 9000
      protocol: TCP
```
Фронт-Deployment:
```yaml
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: front
  namespace: prod
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
        env:
          - name: BASE_URL
            value: http://back:9000
```
Фронт-Service:
```yaml
---
apiVersion: v1
kind: Service
metadata:
  name: front-service
  namespace: prod
spec:
  type: ClusterIP
  selector:
    app: front
  ports:
    - port: 8000
      targetPort: 80
      protocol: TCP
```
Бд-StatefulSet:
```yaml
---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: postgres
  namespace: prod
spec:
  serviceName: postgres-service
  replicas: 1
  selector:
    matchLabels:
      app: postgres
  template:
    metadata:
      labels:
        app: postgres
    spec:
      containers:
        - name: postgres
          image: postgres:13-alpine
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
```
Бд-Service:
```yaml
---
apiVersion: v1
kind: Service
metadata:
  name: postgres-service
  namespace: prod
spec:
  type: ClusterIP
  selector:
    app: postgres
  ports:
    - port: 5432
      targetPort: 5432
      protocol: TCP
```
kubectl create namespace stage
<br>kubectl apply -f stage
<br>![prod-entities](imgs/prod-entities.png)
<br>kubectl port-forward -n prod service/front-service 8081:8000
<br>![prod-curl](imgs/prod-curl.png)
