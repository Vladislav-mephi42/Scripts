#!/usr/bin/bash


set -euo pipefail


general_information(){
    echo "=== SERVER MONITORING ==="
    echo "Date: $(date)"
    echo "Server name: $(hostname)"
    echo "Work time: $(uptime -p)"
    echo ""
}


cpu_information(){
    echo "CPU usaage:"
    load=$(uptime | awk -F'load average: ' '{print $2}' | cut -d, -f1)
    echo "Average load: $load"
    cores=$(grep -c ^processor /proc/cpuinfo)
    echo "Number of cores: $cores"
    echo ""
}

memory_information(){
    echo "Memory usage:"
    free -h | grep -v "Swap" | awk '{print $1,$2,$3,$4}'
    echo ""
    free -h | grep "Swap" | awk '{print $1,$2,$3,$4}'
    echo ""
}

discs_information(){
    echo "Discs usage:"
    df -h | grep -v "tmpfs" | awk '{print $1,$3,$4,$5}'
    echo ""
}

network_intrefaces_information(){
    echo "Network intrefaces:"
    ip -o addr show | grep -v "lo" | awk '{print $2,$4}'
    echo ""
}

while true; do
    general_information
    sleep 1
    cpu_information
    sleep 1
    memory_information
    sleep 1
    discs_information
    sleep 1
    network_intrefaces_information
    sleep 1
    read -p "Do you want to exit ? (y/n): " answer
    if [[ "$answer" == "y" || "$answer" == "Y" ]]; then
        echo "Exit..."
        break
    fi
done

