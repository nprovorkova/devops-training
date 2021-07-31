#!/usr/bin/env python3

import socket

hosts = ('drive.google.com', 'mail.google.com', 'google.com')
# Перебираем хосты
for host in hosts:
    # Строка для хранения нового списка IP - адресов
    currentIpList = ""
    # Получаем актуальный список IP адресов для текущего хоста
    ipAddresses = socket.gethostbyname_ex(host)
    print('< ' + host + ' > - < ' + ', '.join(ipAddresses[2]) + ' >')
    # Открываем файл с предыдущим списком IP адресов для текущего хоста, сохраняем прежние адреса в список
    with open(host + '-ip-services.txt', 'r+') as file:
        oldIpList = file.read().splitlines()
        # Для каждого IP адреса делаем сравнение с предыдущим запросом и сохранение в строку для записи в файл
        for ipAddress in ipAddresses[2]:
            currentIpList += ipAddress + '\n'
            # Ищем в файле текущий IP адрес
            ipFound = ipAddress in oldIpList
            if not ipFound:
                print('[ERROR] < ' + host + ' > IP mismatch: '
                                            '< ' + ', '.join(ipAddresses[2]) + ' > < ' + ', '.join(oldIpList) + ' >')
        # Переписываем файл актуальными значениями IP адресов для хоста
    with open(host + '-ip-services.txt', 'w+') as file:
        file.write(currentIpList)

