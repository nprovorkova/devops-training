### 6.4. PostgreSql
#### 1. Управляющие команды:
1. вывода списка БД
>\l[+] (options: + = additional detail)
2. подключения к БД
>\c[onnect] {[DBNAME|- USER|- HOST|- PORT|-] | conninfo}
3. вывода списка таблиц
>\dt[S+] (options: S = show system objects, + = additional detail)
4. вывода описания содержимого таблиц
>\d[S+] (options: S = show system objects, + = additional detail)
5. выхода из psql
>\q

#### 2. Восстановление из бэкапа 
Столбец таблицы orders с наибольшим средним значением размера элементов в байтах:
>SELECT attname 
> <br>FROM pg_stats 
> <br>WHERE tablename='orders' 
> <br>AND avg_width IN 
> <br>(
> <br>SELECT MAX(avg_width) 
> <br>FROM pg_stats 
> <br>WHERE tablename='orders'
> <br>);

Ответ: title

[Скриншот с запросом](https://github.com/nprovorkova/devops-training/blob/master/06-db-04-postgresql/postgresql/pg_stats.jpg)

#### 3. Шардирование
SQL-транзакция для проведения шардирования:
>BEGIN;
><br><br>CREATE TABLE orders_1 (
><br>CHECK(price>499)
><br>) INHERITS(orders);
><br><br>CREATE TABLE orders_2 (
><br>CHECK(price<=499)
><br>) INHERITS(orders);

>CREATE RULE orders_insert_to_1 AS ON INSERT TO orders
><br>WHERE  (price>499)
><br>DO INSTEAD INSERT INTO orders_1 VALUES (NEW.*);
> 
>CREATE RULE orders_insert_to_2 AS ON INSERT TO orders
><br>WHERE  (price<=499)
><br>DO INSTEAD INSERT INTO orders_2 VALUES (NEW.*);
><br><br>COMMIT;

При проектировании:
>CREATE TABLE orders (
<br>    id integer NOT NULL,
<br>    title character varying(80) NOT NULL,
<br>    price integer DEFAULT 0
<br>) PARTITION BY RANGE (price );
<br><br>CREATE TABLE orders_1 PARTITION OF orders FOR VALUES FROM (499) TO (MAXVALUE);
<br><br>CREATE TABLE orders_2 PARTITION OF orders FOR VALUES FROM
(MINVALUE) TO (499);

#### 4. Бэкап
Бэкап:
>pg_dump -d test_database -U postgres -Fp > /tmp/test_database.sql

Добавление уникальности столбца title:
> CREATE UNIQUE INDEX index_title_unique  ON orders(title);
