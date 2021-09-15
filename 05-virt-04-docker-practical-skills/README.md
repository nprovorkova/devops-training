### 5.4. Практические навыки работы с Docker
#### 1. ponysay
[Докерфайл](https://github.com/nprovorkova/devops-training/blob/master/05-virt-04-docker-practical-skills/ponysay/Dockerfile)
<br>[Скриншот](https://github.com/nprovorkova/devops-training/blob/master/05-virt-04-docker-practical-skills/ponysay/ponysay.jpg)
<br>[Ссылка на образ](https://hub.docker.com/repository/docker/provorkova/netology-ponysay)

#### 2. Jenkins
[Докерфайл amazoncorrtto](https://github.com/nprovorkova/devops-training/blob/master/05-virt-04-docker-practical-skills/jenkins/Dockerfile-amazoncorretto)
<br>[Докерфайл ubuntu](https://github.com/nprovorkova/devops-training/blob/master/05-virt-04-docker-practical-skills/jenkins/Dockerfile-ubuntu)
<br>[Скриншоты логов запущенных контейнеров](https://github.com/nprovorkova/devops-training/blob/master/05-virt-04-docker-practical-skills/jenkins/logs.jpg)
<br>[Скриншоты веб-интерфейса Jenkins amazoncorrtto](https://github.com/nprovorkova/devops-training/blob/master/05-virt-04-docker-practical-skills/jenkins/amazoncorretto.jpg)
<br>[Скриншоты веб-интерфейса Jenkins ubuntu](https://github.com/nprovorkova/devops-training/blob/master/05-virt-04-docker-practical-skills/jenkins/ubuntu.jpg)
<br>[Ссылки на образы в docker-hub](https://hub.docker.com/repository/docker/provorkova/netology-jenkins/tags?page=1&ordering=last_updated)

#### 3. Nodejs
[Докерфайл с npm приложением](https://github.com/nprovorkova/devops-training/blob/master/05-virt-04-docker-practical-skills/nodejs/Dockerfile)
<br>[Скриншот списка docker сетей](https://github.com/nprovorkova/devops-training/blob/master/05-virt-04-docker-practical-skills/nodejs/nodejs%20network.jpg)
<br>[Скриншот вызова утилиты curl с ответом connection refused](https://github.com/nprovorkova/devops-training/blob/master/05-virt-04-docker-practical-skills/nodejs/nodejs%20curl.jpg)

Выполненные команды по заданию:
<br>docker build -t nodejs -f Dockerfile .
<br>docker images 
<br>docker run -d -ti --name nodejs-0 nodejs
<br>docker run -d -ti --name ubuntu-00 --expose=3000 ubuntu:latest
<br>docker network create netology-network
<br>docker network connect  netology-network nodejs-0
<br>docker network connect  netology-network ubuntu-00
<br>docker network inspect netology-network
<br>docker exec -ti ubuntu-00 bash
<br>apt update && apt upgrade
<br>apt install -y curl
<br>curl nodejs-0:3000

