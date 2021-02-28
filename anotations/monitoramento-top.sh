#!/bin/bash

# contador de tempo 
tempo=0

echo "time;users;VirtMem;" > log-top.csv

while [ $tempo -lt 60 ]
do  
    time=$(uptime | awk '{print $1}')
    user=$(uptime | awk '{print $4}')
    virt=$(top -b -n 1 | awk '/chrome/{print $5}' | head -n 1)

    echo "$time;$user;$virt;" >> log-top.csv
    sleep 2
    tempo=$((tempo+2))
done
