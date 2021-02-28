#!/bin/bash

# contador de tempo 
tempo=0

echo "time;cpu0;cpu1;cpu2;cpu3;cput;used;free;shared;total;rawait;wawait" > log-final.csv

while [ $tempo -lt 30 ]
do  
    time=$(uptime | awk '{print $1}')
    cpu0=$(mpstat -P 0 | tail -n 1 |  awk '{print $4}')
    cpu1=$(mpstat -P 1 | tail -n 1 |  awk '{print $4}')
    cpu2=$(mpstat -P 2 | tail -n 1 |  awk '{print $4}')
    cpu3=$(mpstat -P 3 | tail -n 1 |  awk '{print $4}')
    cput=$(mpstat | tail -n 1 |  awk '{print $4}')
    used=$(free -m | awk '/Mem/{print $3}')
    free=$(free -m | awk '/Mem/{print $4}')
    shared=$(free -m | awk '/Mem/{print $5}')
    total=$(free -m | awk '/Mem/{print $2}')
    rawait=$(iostat -x | awk '/sda/{print $6}')
    wawait=$(iostat -x | awk '/sda/{print $12}')

    echo "$time;$cpu0;$cpu1;$cpu2;$cpu3;$cput;$used;$free;$shared;$total;$rawait;$wawait" >> log-final.csv
    sleep 1
    tempo=$((tempo+2))
done
