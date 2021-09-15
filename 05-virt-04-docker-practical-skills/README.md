#5.4. Практические навыки работы с Docker
>1. В данном задании вы научитесь изменять существующие Dockerfile, адаптируя их под нужный инфраструктурный стек.
>Измените базовый образ предложенного Dockerfile на Arch Linux c сохранением его функциональности.
>FROM ubuntu:latest
>RUN apt-get update && \
>    apt-get install -y software-properties-common && \
>    add-apt-repository ppa:vincent-c/ponysay && \
>    apt-get update 
>RUN apt-get install -y ponysay
>ENTRYPOINT ["/usr/bin/ponysay"]
>CMD ["Hey, netology”]
>Для получения зачета, вам необходимо предоставить:
>Написанный вами Dockerfile

[Докерфайл](https://github.com/nprovorkova/devops-training/blob/master/05-virt-04-docker-practical-skills/ponysay/Dockerfile)

>Скриншот вывода командной строки после запуска контейнера из вашего базового образа
