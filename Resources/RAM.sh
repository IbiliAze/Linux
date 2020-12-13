#!/bin/bash



[ free ]

free #amount of free RAM and SWAP

free -g #-g=gigabytes

free -m #-m=megabytes

free -h #-h=human readable

free -h -s 5 #-s=every x seconds



[ vmstat ]

vmstat

vmstat -a

vmstat 5 #5=every 5 seconds

vmstat 5 -t #-t=timestamp

vmstat -s #-s=summary

while true; do vmstat -s; sleep 5; done



