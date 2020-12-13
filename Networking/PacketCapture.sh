#!/bin/bash


sudo tcpdump #traffic analyser
sudo tcpdump -i ens33 #-i interface
sudo tcpdump -i ens33 > data.txt
sudo tcpdump -i ens33 port 80
