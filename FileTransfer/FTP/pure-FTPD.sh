#!/bin/bash



apt install -y pure-ftpd ftp

cat /etc/pure-ftpd/pure-ftpd.conf #not a configuration file, only command line

pure-ftpd -B #-B=run in background, (daemon mode)

pure-ftpd -B -S localhost,21 #-S=bind 

pure-ftpd -B -S localhost,21 -c 5 #-c=number of concurrent connections

pure-ftpd -B -S localhost,21 -c 5 -C 2 #-C=max clients per IP

pure-ftpd -B -S localhost,21 -c 5 -C 2 -e #-e=permit anonymous access

pure-ftpd -B -S localhost,21 -c 5 -C 2 -E #-E=disable anonymous access

ps aux | grep pure-ftpd

killall pure-ftpd




