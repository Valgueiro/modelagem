#!/bin/bash

# contador de tempo 
tempo=0

echo "MemFree;Buffers;Cached;SwapFree;" > log-mem-proc.csv

while [ $tempo -lt 60 ]
do  
    # awk serve para pegar uma linha ou uma coluna
    # nesse caso estamos pegando a segunda coluna da linha que tem
    # "/MemFree"
    mfree=$(cat /proc/meminfo | awk '/MemFree/{print $2}')
    buffer=$(cat /proc/meminfo | awk '/Buffers/{print $2}')
    # ^ força que inicie com essa letra (igual regex)
    cached=$(cat /proc/meminfo | awk '/^Cached/{print $2}')
    swapFree=$(cat /proc/meminfo | awk '/SwapFree/{print $2}')

    echo "$mfree;$buffer;$cached;$swapFree;" >> log-mem-proc.csv
    sleep 1
    # usar parenteses duplos quando quiser fazer conta aritmética
    tempo=$((tempo+2))
done

