#!/bin/bash

# Количество процессов для отображения
NUM_PROCESSES=20

# Команда мониторинга
CMD="free -h; echo; ps -ax -o pid,comm,pcpu,pmem,rss,user --sort=-pmem | head -n $((NUM_PROCESSES + 1))"

# Запуск мониторинга с обновлением каждые 2 секунды
watch -n 2 "$CMD"
