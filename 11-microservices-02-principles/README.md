### 11.2 Микросервисы: принципы - Наталия Проворкова
#### 1. API Gateway
```
Предложите решение для обеспечения реализации API Gateway. Составьте сравнительную таблицу возможностей различных программных решений. На основе таблицы сделайте выбор решения.
Решение должно соответствовать следующим требованиям:
Маршрутизация запросов к нужному сервису на основе конфигурации
Возможность проверки аутентификационной информации в запросах
Обеспечение терминации HTTPS
Обоснуйте свой выбор.
```
| Решение             |Маршрутизация запросов на основе конфигурации    |Возможность проверки аутентификационной информации в запросах    | Обеспечение терминации HTTPS |
|:---                 |:---        |:---        |:---        |
| Kong Gateway        | +   | + | + |
| Apache APISIX       | +   | + | + |
| Gloo                | +   | + | + |
| Istio               | +   | + | + |
| MuleSoft            | +   | + | + |
| Apigee              | +   | + | + |
| Oracle API Platform | +   | + | + |
| Amazon API Gateway  | +   | + | + |
| Yandex API Gateway  | +   | + | + |
| Azure               | +   | + | + |

Все перечисленные реализации соответствуют требованиям. На основе исследования сделан вывод, что Apigee и MuleSoft — одни из лучших инструментов управления API. Также интересно решение с открытым исходным кодом - Kong, его базовый бесплатный функционал удовлетворяет требованиям задачи.
###### 2. Брокер сообщений
```
Составьте таблицу возможностей различных брокеров сообщений. На основе таблицы сделайте обоснованный выбор решения.
Решение должно соответствовать следующим требованиям:
Поддержка кластеризации для обеспечения надежности
Хранение сообщений на диске в процессе доставки
Высокая скорость работы
Поддержка различных форматов сообщений
Разделение прав доступа к различным потокам сообщений
Протота эксплуатации
Обоснуйте свой выбор.
```
| Решение      |Поддержка кластеризации    |Хранение сообщений на диске в процессе доставки    | Высокая скорость работы| Поддержка различных форматов сообщений | Разделение прав доступа к различным потокам сообщений | Простота эксплуатации |
|:---          |:---        |:---        |:---        |:---        |:---        |:---        |
| Kafka        | + | + | ++ | + | + | + |
| RabbitMQ     | + | + | +  | + | + | + |
| Redis        | + | + | ++ | + | + | + |
| Qpid         | + | + | -  | + | + | - |
| SwiftMQ      | + | + | -  | + | + | - |
| Artemis      | + | + | -  | + | + | + |
| Apollo       | - | + | -  | + | + | + |

Требованиям соответствуют Kafka, Redis, RabbitMQ. В универсальном случае я бы предложила использовать Kafka, так как он современный и надежный.