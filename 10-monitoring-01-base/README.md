### 10.1. Зачем и что нужно мониторить - Наталия Проворкова
#### 1. Вас пригласили настроить мониторинг на проект. На онбординге вам рассказали, что проект представляет из себя платформу для вычислений с выдачей текстовых отчетов, которые сохраняются на диск. Взаимодействие с платформой осуществляется по протоколу http. Также вам отметили, что вычисления загружают ЦПУ. Какой минимальный набор метрик вы выведите в мониторинг и почему?
* CPU
* RAM
* inodes  
* Возможность установления связи c платформой
* Коэффициенты ошибок и потери пакетов
* Время затраченное на запрос
* Мониторинг загруженного объёма сети от доступного

#### 2. Менеджер продукта посмотрев на ваши метрики сказал, что ему непонятно что такое RAM/inodes/CPUla. Также он сказал, что хочет понимать, насколько мы выполняем свои обязанности перед клиентами и какое качество обслуживания. Что вы можете ему предложить?
CPU - нагруженность процессора 
inodes - нагруженность ФС 
RAM - нагруженность оперативной памяти

Предложу заключить соглашение об уровне обслуживания (SLA): 
* согласуем % времени, когда платформа будет доступна
* для каждого вида отчета согласуем время выполнения отчета
* отношение успешно построенных отчетов ко всем отчетам

#### 3. Вашей DevOps команде в этом году не выделили финансирование на построение системы сбора логов. Разработчики в свою очередь хотят видеть все ошибки, которые выдают их приложения. Какое решение вы можете предпринять в этой ситуации, чтобы разработчики получали ошибки приложения?
* Пусть смотрят логи в подах своих микросервисов в Kubernetes, если нам не выделили даже сервер для ELK
* Настроим ELK

#### 4. Вы, как опытный SRE, сделали мониторинг, куда вывели отображения выполнения SLA=99% по http кодам ответов. Вычисляете этот параметр по следующей формуле: summ_2xx_requests/summ_all_requests. Данный параметр не поднимается выше 70%, но при этом в вашей системе нет кодов ответа 5xx и 4xx. Где у вас ошибка?
Совсем забыла, что есть коды ответов 3хх, связанные с редиректом и 1хх - информационные сообщения. В следующий раз буду внимательнее.