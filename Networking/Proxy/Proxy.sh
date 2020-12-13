#!/bin/bash


[ Basic Proxy Config ]

#Proxy Server
sudo su
yum install -y squid
systemctl start squid
firewall-cmd --permanent --add-service=squid
firewall-cmd --reload
cat /etc/squid/squid.conf | grep "^[^#]" #enabled configs, order matters
tail /var/log/squid/access.log 
tail /var/log/squid/access.log -f 

#Client
export http_proxy="http://172.31.29.56:3128" #IP=proxy server 
curl -I linuxacademy.com



[ Blacklist ] 

vim /etc/squid/squid.conf
#Under: # INSERT YOUR OWN RULE(S) HERE TO ALLOW ACCESS FROM YOUR CLIENTS
> acl acl1blacklist dstdomain .facebook.com
> http_access deny acl1blacklist
systemctl restart squid



[ Bandwidth Constraints ]

vim /etc/squid/squid.conf
#Under: # INSERT YOUR OWN RULE(S) HERE TO ALLOW ACCESS FROM YOUR CLIENTS
> acl bwacl src 172.31.27.0/24
> delay_pools 1 #1 = pool number
> delay_class 1 3 #3 = class
> delay_access 1 allow bwacl
> delay_access 1 deny all
> delay_parameters 1 64000/64000 -1/-1 16000/64000
systemctl restart squid




