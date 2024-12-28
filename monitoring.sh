#!/bin/bash
architecture=$(uname -a)
pcpu=$(lscpu | grep "Socket(s)" | awk '{print     $2}')
vcpu=$(nproc)
mem_usage=$(free -m | awk '/Mem:/ {printf "#Available ram memory: %d/%dMB || Utilization: %.2f%%\n", $7, $2, ($3/$2)*100}')
disk_available=$(df --output=avail | tail -n +2 | awk '{total+=$1} END {printf "#Available disk memory: %.2fGB", total/1024/1024}')
disk_usage=$(df --output=used,size | tail -n +2 | awk '{used+=$1; total+=$2} END {printf "|| Utilization: %.2f%%\n", (used/total)*100}')
cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print "CPU Utilization: " $2 + $4 "%"}')

echo "$cpu_usage"

message="#Architecture: $architecture
#CPU physical $pcpu"

wall "$message"

#echo -n "#Architecture: " && uname -a
#echo -n "#CPU physical: " && lscpu | grep "Socket(s)" | awk '{print $2}'
#echo -n "vCPU: " && nproc
#free -m | awk '/Mem:/ {printf "#Available memory: %d/%dMB || Utilization: %.2f%%\n", $7, $2, ($3/$2)*100}'
