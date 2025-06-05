#!/bin/bash

# Используем переданный аргумент или значение по умолчанию
NUM_PROCESSES=${1:-20}

CMD="free -h; echo; ps -ax -o pid,comm,pcpu,pmem,rss,user --sort=-pmem | head -n $((NUM_PROCESSES + 1))"

watch -n 2 "$CMD"
