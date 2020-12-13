#!/bin/bash


timedatectl #time info
timedatectl list-timezones
timedatectl set-time 9:00:00
timedatectl set-ntp off
hwclock #hardware clock
date #system clocl
hwclock -w #system clock > hardware clock
cat /etc/chrony.conf #ntp config
systemctl restart chronyd.service
chronyc #chrony client