#!/bin/bash

tempo=0
time_between_calls=5

# pegar estatísticas por 10 minutos
# 10*60 = 600 segundos => 600/5 = 120 ciclos
cicles=120

output_file='log-lista1.csv'

# pegar o pid do primeiro processo do chorme
pid=$(ps aux | grep chrome | awk '{print $2}' | head -n 1)

# adicionar header
echo "time;cpu_per;cpu_core;read_per_s;ram_used;ram_free;ram_buff_cache" > $output_file

while [ $tempo -lt $cicles ]
do  
    # pegar informacoes
    time=$(uptime | awk '{print $1}')
    cpu_per=$(pidstat -p $pid | tail -n 1 | awk '{print $9}')
    cpu_core=$(pidstat -p $pid | tail -n 1 | awk '{print $10}')
    read_per_s=$(pidstat -p $pid -d | tail -n 1 | awk '{print $6}')
    ram_used=$(free -m | awk '/Mem/{print $3}')
    ram_free=$(free -m | awk '/Mem/{print $4}')
    ram_buff_cache=$(free -m | awk '/Mem/{print $6}')

    # colocar as informações no output
    echo "$time;$cpu_per;$cpu_core;$read_per_s;$ram_used;$ram_free;$ram_buff_cache" >> $output_file

    # delay
    sleep $time_between_calls
    tempo=$((tempo+1))
done

echo "Done"
