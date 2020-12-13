#!/bin/bash


[ Status ]

systemctl firewalld status #check if firewalld is running

sudo firewall-cmd --state #check if firewalld is running 



[ Zones ] 

sudo firewall-cmd --get-zones #get firewall zones, think DMZ

sudo firewall-cmd --get-default-zone #current zone

sudo firewall-cmd --get-active-zones

sudo firewall-cmd --permanent --new-zone=test_zone #--permanent firewalld requires configs to be written to disk, default is to RAM, then we will need to restart firewalld to apply the changes to ram
sudo firewall-cmd --reload #apply changes from disk to RAM



[ Config ]

cat /etc/sysconfig/network-scripts/ifcfg-ens33 #interface configurations for ens33
systemctl restart network #restart the network service and the interfaces
systemctl restart firewalld #same as above

sudo firewall-cmd --get-services

sudo ls /usr/lib/firewalld/services #xml files defining services

sudo firewall-cmd --zone=public --permanent --add-service=http #allow http
sudo firewall-cmd --reload

sudo firewall-cmd --zone=public --list-services #see what's configured/approved on the ram^^^

sudo firewall-cmd --zone=public --permanent --list-services #see what's configured/approved on the disk^^^

sudo firewall-cmd --zone=public --permanent --add-port=8080/tcp #add a port as a service

sudo firewall-cmd --zone=public --permanent --add-port=50000-60000/udp #add ports as a service within a range

sudo firewall-cmd --permanent --list-ports #see what ports are configured/approved


