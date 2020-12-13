#!/bin/bash


[ Test Failover ]

mdadm -f /dev/md0 /dev/sdb1 #-f=fail, fail the sdb1 device from the md0 RAID Array
mdadm -D /dev/md0 #a new disk should replace if you have spare disks in the RAID config
ll /mnt/data/ #check the files still exist in the mounted directory for md0



[ Misc ]

mdadm -r /dev/md0 /dev/sdb2 #-r=remove

mdadm -r /dev/md0 /dev/sdb2 /dev/sdb3 #remove multiple

mdadm -a /dev/md0 /dev/sdb2 #-a=add
mdadm -D -s -v /etc/mdadm.conf #update the config

mdadm -a /dev/md0 /dev/sdb2 /dev/sdb3 #add multiple
mdadm -D -s -v /etc/mdadm.conf #update the config



