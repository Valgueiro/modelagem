#!/bin/bash

sudo tcpdump -c 100 -i wlp2s0 -s 60 -w monitoramentoQ2.pcap tcp

echo "Done"
