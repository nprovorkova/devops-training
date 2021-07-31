#!/usr/bin/env python3

import socket

hosts = ('drive.google.com', 'mail.google.com', 'google.com')
with open('ip-services.json', 'w+') as json:
    with open('ip-services.yml', 'w+') as yaml:
        json.write('{ "ip-services" : [\n')
        firstHost = True
        # Перебираем хосты
        for host in hosts:
            # Строка для хранения нового списка IP - адресов
            currentIpList = ""
            # Получаем актуальный список IP адресов для текущего хоста
            ipAddresses = socket.gethostbyname_ex(host)
            print('< ' + host + ' > - < ' + ', '.join(ipAddresses[2]) + ' >')
            if firstHost:
                json.write('{ "' + host + '" : ["' + '", "'.join(ipAddresses[2]) + '"]}')
            else:
                json.write(',\n{ "' + host + '" : ["' + '", "'.join(ipAddresses[2]) + '"]}')
            yaml.write('- ' + host + ': ["' + '", "'.join(ipAddresses[2]) + '"]\n')
            firstHost = False
            # Открываем файл с предыдущим списком IP адресов для текущего хоста, сохраняем прежние адреса в список
            with open(host + '-ip-services.txt', 'a+') as file:
                file.seek(0)
                oldIpList = file.read().splitlines()
                # Для каждого IP адреса делаем сравнение с предыдущим запросом и сохранение в строку для записи в файл
                for ipAddress in ipAddresses[2]:
                    currentIpList += ipAddress + '\n'
                    # Ищем в файле текущий IP адрес
                    ipFound = ipAddress in oldIpList
                    if not ipFound:
                        print('[ERROR] < ' + host + ' > IP mismatch: < ' +
                              ', '.join(ipAddresses[2]) + ' > < ' + ', '.join(oldIpList) + ' >')
            # Переписываем файл актуальными значениями IP адресов для хоста
            with open(host + '-ip-services.txt', 'w+') as file:
                file.write(currentIpList)
        json.write('\n]}')
# К уже реализованному функционалу нам нужно
# добавить возможность записи JSON и YAML файлов, описывающих наши сервисы.
# Формат записи JSON по одному сервису: { "имя сервиса" : "его IP"}.
# Формат записи YAML по одному сервису: - имя сервиса: его IP.
# Если в момент исполнения скрипта меняется IP у сервиса - он должен так же поменяться в yml и json файле.