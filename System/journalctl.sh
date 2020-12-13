#!/bin/bash


[ Permenant logs ]

mkdir -o /var/log/journal
systemd-tmpfiles --create -prefix /var/log/journal



[ conf File ]

sudo vim /etc/systemd/journald.conf
>storage=auto #default, if exists stored in /var/log/journal hierarchy
>storage=persistent #stored in /var/log/journal hierarchy
>storage=volatile #stored on RAM
>storage=none #all log data is dropped

>compress=yes
>compress=no

>SystemMaxUse= #disk usage, default is 10%
>RuntimeMaxUse= #RAM usage, default is 10%

>SystemMaxFileSize= #size of individual journal files on disk
>RuntimeMaxFileSize= #size of individual journal files on RAM

>MaxRetentionSec= #the amount of time to store journal entries, default is 0 (disabled)



[ Commands ]

journalctl

journalctl -r #reverse the output to see the latest logs
journalctl -e #end of logs
journalctl -n 20 #last 20 lines
journalctl -f #watch/follow
journalctl -f -n 20 #watch/follow & limit output/tail
journalctl -u httpd.service #only for unit files

journalctl -o verbose #output
journalctl -o json
journalctl -o json-pretty

echo "test log" | systemd-cat #send own log message

journalctl -x #helps to troubleshoot (service catalog)
journalctl -k #kernel messages
journalctl -b #boot-up messages
journalctl --list-boots #recorded boot sessions

journalctl --since
journalctl --untill
journalctl --disk-usage
journalctl --rotate
