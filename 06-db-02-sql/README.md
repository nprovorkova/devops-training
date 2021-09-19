### 6.2. Sql
#### 1. docker-postgres
[docker-compose.yml](https://github.com/nprovorkova/devops-training/blob/master/06-db-02-sql/postgres-docker/docker-compose.yml)

#### 2. Создание пользователя и БД
[Итоговый список БД](https://github.com/nprovorkova/devops-training/blob/master/06-db-02-sql/postgres-docker/db_list.jpg)
<br>[Описание таблиц](https://github.com/nprovorkova/devops-training/blob/master/06-db-02-sql/postgres-docker/tables_info.jpg)
<br><br>SQL-запрос для выдачи списка пользователей с правами над таблицами test_db:
>SELECT grantee, table_name, privilege_type 
<br>FROM information_schema.table_privileges 
<br>WHERE table_name='clients' OR 'orders';

[Список пользователей с правами над таблицами test_db](https://github.com/nprovorkova/devops-training/blob/master/06-db-02-sql/postgres-docker/grantee.jpg)

#### 3. Заполнение таблиц данными
[Заполнение orders](https://github.com/nprovorkova/devops-training/blob/master/06-db-02-sql/postgres-docker/insert_orders.jpg)

>INSERT INTO orders (name, price) 
><br>VALUES ('Шоколад', 10), ('Принтер', 3000), ('Книга', 500), ('Монитор', 7000), ('Гитара', 4000);

[Заполнение clients](https://github.com/nprovorkova/devops-training/blob/master/06-db-02-sql/postgres-docker/insert_clients.jpg)

>INSERT INTO clients (full_name, residence_country) 
><br>VALUES ('Иванов Иван Иванович', 'USA'), ('Петров Петр Петрович', 'Canada'), ('Иоганн Себастьян Бах', 'Japan'), ('Ронни Джеймс Дио', 'Russia'), ('Ritchie Blackmore', 'Russia');

[Количество записей orders](https://github.com/nprovorkova/devops-training/blob/master/06-db-02-sql/postgres-docker/count_orders.jpg)

>SELECT count(*) FROM orders;

[Количество записей clients](https://github.com/nprovorkova/devops-training/blob/master/06-db-02-sql/postgres-docker/count_clients.jpg)

>SELECT count(*) FROM clients;

#### 4. Обновление таблиц

[Связка записей таблиц](https://github.com/nprovorkova/devops-training/blob/master/06-db-02-sql/postgres-docker/updates.jpg)

>UPDATE clients SET order_id = 
><br>( SELECT id FROM orders 
><br>WHERE name = 'Книга'
> <br>) 
<br>WHERE full_name = 'Иванов Иван Иванович';
<br><br>UPDATE clients SET order_id = 
> <br>( SELECT id FROM orders 
> <br>WHERE name = 'Монитор'
> <br>) 
<br>WHERE full_name = 'Петров Петр Петрович';
<br><br>UPDATE clients SET order_id = 
> <br>( SELECT id FROM orders 
> <br>WHERE name = 'Гитара'
> <br>) 
<br>WHERE full_name = 'Иоганн Себастьян Бах';

[Пользователи, которые совершили заказ](https://github.com/nprovorkova/devops-training/blob/master/06-db-02-sql/postgres-docker/clients_with_order.jpg)

>SELECT full_name FROM clients WHERE order_id IS NOT NULL;

#### 5. План запроса

[Полная информация по запросу выдачи всех пользователей](https://github.com/nprovorkova/devops-training/blob/master/06-db-02-sql/postgres-docker/explain.jpg)

Последовательное сканирование, 
<br>время выполнения запроса в условных единицах - 11.4, 
<br>приблизительно возвращаемое число строк - 189, 
<br>средний размер строк в байтах - 418

#### 6. Бэкап и восстановление
1. pg_dump  test_db >/backup/dump_test_db.sql
2. docker stop postgres
3. docker rm postgres
4. Перед стартом удален volume с данными (first-postgres-volume:/var/lib/postgresql/data)
5. docker-compose up -d dbpostgres
6. docker exec -it postgres bash
7. CREATE DATABASE test_db;
8. psql test_db</backup/dump_test_db.sql