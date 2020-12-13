#!/bin/bash




[ netstat ]

yum provides */netstat
yum install -y net-tools

netstat -r #-r=routing table

netstat -s #-s=display networking statistics for Protocols

netstat -l #-l=listening
netstat -lt #-t=TCP
netstat -lu #-u=UDP

netstat -lc #-c=continous (think follow)

netstat -lp #-p=additional info surrounding the pid



[ ss ]

ss #same as above



[ iptraf ]

yum install -y iptraf-ng

iptraf-ng #packet capture

