#!/bin/bash

echo "IP Адреса системы:"
ip a | grep -w inet | grep -v '127.0.0.1' | awk '{print $2}'

echo "Общий разход памяти на сервере"
free -h
echo ""

echo "Статус лужбы 1С"
systemctl status srv1cv8-8.3.25.1560@default.service --no-pager --lines=0
echo ""

echo "Процессы пользователя usr1cv8:"
ps -u usr1cv8 --sort=-%mem -o pid,%cpu,%mem,comm
echo
pids=$(ps -u usr1cv8 -o pid=)
if [[ -z "$pids" ]]; then
    echo "Нет активных процессов для usr1cv8"
    exit 0
fi

echo "Слушающие порты для этих PID:"
ss -t4lpn | while read -r line; do
    for pid in $pids; do
        if echo "$line" | grep -q "pid=$pid,"; then
            echo "$line"
        fi
    done
done
echo ""

echo "Логи технологического журнала"
du -sh /home/usr1cv8/.1cv8/1C/1cv8/logs/*
echo ""

echo "Примонтированные каталоги"
findmnt -D /mnt/1cfiles