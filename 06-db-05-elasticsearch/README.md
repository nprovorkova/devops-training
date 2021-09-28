### 6.5. ElasticSearch
#### 1. Dockerfile:
[Dockerfile-манифест для elasticsearch](https://github.com/nprovorkova/devops-training/blob/master/06-db-05-elasticsearch/Dockerfile)
<br>[Ссылка на образ](https://hub.docker.com/repository/docker/provorkova/netology-elasticsearch)
<br>[Запрос localhost:9200](https://github.com/nprovorkova/devops-training/blob/master/06-db-05-elasticsearch/start-elasticsearch.jpg)

#### 2. Добавление индексов 
[Список индексов и их статусов](https://github.com/nprovorkova/devops-training/blob/master/06-db-05-elasticsearch/list-indices.jpg)
<br>[Состояние кластера elasticsearch](https://github.com/nprovorkova/devops-training/blob/master/06-db-05-elasticsearch/cluster-health.jpg)

Часть индексов и кластер находятся в состоянии yellow, так как 
количество реплик >= количество узлов
<br>Elasticsearch не назначает реплику тому же узлу, что и основной сегмент, так как есть только один узел, статус кластера - желтый.
<br>Точно так же, если количество реплик >= количество узлов, то невозможно назначить один или несколько шардов.


#### 3. Бэкап
Запрос API для создания репозитория:
>curl -X PUT "localhost:9200/_snapshot/netology_backup?pretty" -H 'Content-Type: application/json' -d'
<br>{
<br>"type": "fs",
<br>  "settings": {
<br>    "location": "elasticsearch-7.15.0/snapshots"
<br>  }
<br>}
<br>'

[Результат вызова API для создания репозитория](https://github.com/nprovorkova/devops-training/blob/master/06-db-05-elasticsearch/create-backup-repo.jpg)
[Список индексов](https://github.com/nprovorkova/devops-training/blob/master/06-db-05-elasticsearch/backup-list-indeces.jpg)
[Список файлов в директории со snapshotами](https://github.com/nprovorkova/devops-training/blob/master/06-db-05-elasticsearch/backup-list-snapshots.jpg)
[Обновленный список индексов](https://github.com/nprovorkova/devops-training/blob/master/06-db-05-elasticsearch/list-indeces-after-backup.jpg)

Запрос к API восстановления состояния кластера elasticsearch из snapshot, созданного ранее:

>curl -X POST "localhost:9200/_snapshot/netology_backup/snapshot_2/_restore?pretty"

[Итоговый список индексов](https://github.com/nprovorkova/devops-training/blob/master/06-db-05-elasticsearch/result-indeces-after-backup.jpg)



