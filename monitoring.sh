#!/bin/bash
architecture=$(uname -a)

pcpu=$(lscpu | grep "Socket(s)" | awk '{print     $2}')

vcpu=$(nproc)

mem_usage=$(free -m | awk '/Mem:/ {printf "#Available ram memory: %d/%dMB || Utilization: %.2f%%\n", $7, $2, ($3/$2)*100}')

disk_available=$(df --output=avail | tail -n +2 | awk '{total+=$1} END {printf "#Available disk memory: %.2fGB", total/1024/1024}')

disk_usage=$(df --output=used,size | tail -n +2 | awk '{used+=$1; total+=$2} END {printf "|| Utilization: %.2f%%\n", (used/total)*100}')

cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print "CPU Utilization: " $2 + $4 "%"}')

last_boot=$(who -b | awk '{print $3 " " $4}')

#LVM_STATUS CHECKER
if systemctl --quiet is-active lvm2-lvmetad.service; then
    LVM_status="yes";
else
    LVM_status="no";
fi
#------------------

active_connections=$(ss -H -t state established | wc -l)

current_users=$(users | wc -w)

ipv4_address=$(hostname -I)

mac_address=$(ip link show | grep ether | awk '{print $2}')

sudo_counter=$(journalctl | grep sudo | wc -l)

#echo "$cpu_usage"

message="#Architecture: $architecture
#CPU physical $pcpu"

wall "$message"

#echo -n "#Architecture: " && uname -a
#echo -n "#CPU physical: " && lscpu | grep "Socket(s)" | awk '{print $2}'
#echo -n "vCPU: " && nproc
#free -m | awk '/Mem:/ {printf "#Available memory: %d/%dMB || Utilization: %.2f%%\n", $7, $2, ($3/$2)*100}'
