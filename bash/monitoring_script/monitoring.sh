#!/usr/bin/bash



echo "=== МОНИТОРИНГ СЕРВЕРА ==="
echo "Дата: $(date)"
echo "Имя сервера: $(hostname)"
echo "Время работы: $(uptime -p)"
echo ""

echo "Загрузка CPU:"
load=$(uptime | awk -F'load average: ' '{print $2}' | cut -d, -f1)
echo "Средняя загрузка: $load"
cores=$(grep -c ^processor /proc/cpuinfo)
echo "Количество ядер: $cores"
echo ""

echo "Использование памяти:"
free -h | grep -v "Swap" | awk '{print $1,$2,$3,$4}'
echo ""
free -h | grep "Swap" | awk '{print $1,$2,$3,$4}'
echo ""

echo "Использование дисков:"
df -h | grep -v "tmpfs" | awk '{print $1,$3,$4,$5}'
echo ""


echo "Сетевые интерфейсы:"
ip -o addr show | grep -v "lo" | awk '{print $2,$4}'
echo ""