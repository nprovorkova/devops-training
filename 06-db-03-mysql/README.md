### 6.2. Sql
#### 1. docker-mysql
[Скриншот статуса БД](https://github.com/nprovorkova/devops-training/blob/master/06-db-03-mysql/my-sql/status.jpg)
>Server version:  8.0.26 MySQL Community Server - GPL

[Скриншот таблиц БД test_db](https://github.com/nprovorkova/devops-training/blob/master/06-db-03-mysql/my-sql/tables.jpg)
<br>[Скриншот запроса количества записей с price > 300](https://github.com/nprovorkova/devops-training/blob/master/06-db-03-mysql/my-sql/select.jpg)
Ответ: 1.

#### 2. Создание пользователя 
>CREATE USER 'test' 
<br>IDENTIFIED WITH mysql_native_password BY 'test-pass'
<br>PASSWORD EXPIRE INTERVAL 180 DAY
<br>FAILED_LOGIN_ATTEMPTS 3
<br>ATTRIBUTE '{"surname": "Pretty", "first_name": "James"}'; 
<br><br>ALTER USER 'test' WITH MAX_QUERIES_PER_HOUR 100; 
<br><br>GRANT SELECT ON test_db.* TO 'test'; 
<br><br>SELECT *
<br>FROM INFORMATION_SCHEMA.USER_ATTRIBUTES
<br>WHERE USER='test';

[Скриншот с данными по пользователю test](https://github.com/nprovorkova/devops-training/blob/master/06-db-03-mysql/my-sql/user_attributes.jpg)

#### 3. Профилирование
>SELECT TABLE_NAME, ENGINE FROM information_schema.TABLES WHERE TABLE_SCHEMA = 'test_db';
<br>ALTER TABLE orders ENGINE = InnoDB;
<br>ALTER TABLE orders ENGINE = MyISAM;

[Скриншот времени выполнения и запроса на изменения из профайлера](https://github.com/nprovorkova/devops-training/blob/master/06-db-03-mysql/my-sql/change_engine.jpg)

#### 4. Конфигурация
>innodb_flush_method = O_DSYNC
<br>innodb_file_per_table = 1
<br>innodb_log_buffer_size = 1M
<br>innodb_buffer_pool_size = 3G
<br>innodb_log_file_size = 100M

[Скриншот файла my.cnf](https://github.com/nprovorkova/devops-training/blob/master/06-db-03-mysql/my-sql/cnfg.jpg)
