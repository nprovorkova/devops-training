### 11.3 Микросервисы: подходы - Наталия Проворкова
#### 1. Обеспечить разработку
```
Предложите решение для обеспечения процесса разработки: хранение исходного кода, непрерывная интеграция и непрерывная поставка. Решение может состоять из одного или нескольких программных продуктов и должно описывать способы и принципы их взаимодействия.
Решение должно соответствовать следующим требованиям:

Облачная система;
Система контроля версий Git;
Репозиторий на каждый сервис;
Запуск сборки по событию из системы контроля версий;
Запуск сборки по кнопке с указанием параметров;
Возможность привязать настройки к каждой сборке;
Возможность создания шаблонов для различных конфигураций сборок;
Возможность безопасного хранения секретных данных: пароли, ключи доступа;
Несколько конфигураций для сборки из одного репозитория;
Кастомные шаги при сборке;
Собственные докер образы для сборки проектов;
Возможность развернуть агентов сборки на собственных серверах;
Возможность параллельного запуска нескольких сборок;
Возможность параллельного запуска тестов;
Обоснуйте свой выбор.
```
GitLab соответствует представленным требованиям. Он позволяет полностью контролировать производственный цикл ПО. Прост и понятен для разработчиков, удобен тем, что для описания пайплайнов используется Yaml.
###### 2. Логи
```
Предложите решение для обеспечения сбора и анализа логов сервисов в микросервисной архитектуре. Решение может состоять из одного или нескольких программных продуктов и должно описывать способы и принципы их взаимодействия.
Решение должно соответствовать следующим требованиям:

Сбор логов в центральное хранилище со всех хостов обслуживающих систему;
Минимальные требования к приложениям, сбор логов из stdout;
Гарантированная доставка логов до центрального хранилища;
Обеспечение поиска и фильтрации по записям логов;
Обеспечение пользовательского интерфейса с возможностью предоставления доступа разработчикам для поиска по записям логов;
Возможность дать ссылку на сохраненный поиск по записям логов;
Обоснуйте свой выбор.
```
Для сбора логов предлагаю классический подход с ELK. ElasticSearch обеспечивает централизованный сбор логов, Logstash обеспечивает преобразование данных, Kibana используется для визуализации.
###### 3. Мониторинг
```
Предложите решение для обеспечения сбора и анализа состояния хостов и сервисов в микросервисной архитектуре. Решение может состоять из одного или нескольких программных продуктов и должно описывать способы и принципы их взаимодействия.
Решение должно соответствовать следующим требованиям:

Сбор метрик со всех хостов, обслуживающих систему;
Сбор метрик состояния ресурсов хостов: CPU, RAM, HDD, Network;
Сбор метрик потребляемых ресурсов для каждого сервиса: CPU, RAM, HDD, Network;
Сбор метрик, специфичных для каждого сервиса;
Пользовательский интерфейс с возможностью делать запросы и агрегировать информацию;
Пользовательский интерфейс с возможность настраивать различные панели для отслеживания состояния системы;
Обоснуйте свой выбор.
```
Для мониторинга предлагаю использовать классическое сочетание Prometheus + Grafana. Prometheus легко используется "из коробки", Grafana является самой популярной в мире технологией для создания панелей мониторинга, поддерживает множество источников данных. Подойдет для визуализации логов из задания 2.  