#!/bin/bash

SERVICE="srv1cv8-8.3.25.1560@default.service"
USER="usr1cv8"

echo "IP Адреса системы:"
ip a | grep -w inet | grep -v '127.0.0.1' | awk '{print $2}'

echo "Общий разход памяти на сервере"
free -h
echo ""

echo "Статус службы 1С"
if ! systemctl status $SERVICE --no-pager --lines=0; then
    echo "Служба $SERVICE не найдена. Выход."
    exit 1
fi
echo ""

echo "Процессы пользователя $USER:"
ps -u $USER --sort=-%mem -o pid,%cpu,%mem,comm
echo
pids=$(ps -u $USER -o pid=)
if [[ -z "$pids" ]]; then
    echo "Нет активных процессов для $USER"
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