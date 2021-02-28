#!/bin/bash

# contador de tempo 
tempo=0

echo "State;VmSize;VmHWM;VmRSS;" > log-mem-processo.csv

# pegar o pid do primeiro processo do chorme
pid=$(ps aux | grep chrome | awk '{print $2}' | head -n 1)

while [ $tempo -lt 60 ]
do  
    state=$(cat /proc/$pid/status | awk '/State/{print $2}')
    vmsize=$(cat /proc/$pid/status | awk '/VmSize/{print $2}')
    vmhwm=$(cat /proc/$pid/status | awk '/VmHWM/{print $2}')
    vmrss=$(cat /proc/$pid/status | awk '/VmRSS/{print $2}')

    echo "$state;$vmsize;$vmhwm;$vmrss;" >> log-mem-processo.csv
    sleep 2
    # usar parenteses duplos quando quiser fazer conta aritmética
    tempo=$((tempo+2))
done
