#!/bin/bash


[ Initial Connection ]

sudo apt install -y ncat #for listening on a port
nc -l 8080 #test run on front facing public machine to listen on port 8080
telnet 54.163.176.159 8080 #run on local machine to test connection
vim /etc/httpd/conf/httpd.conf #change the listening port to 8080
ss -lntp | grep 8080



[ NAT ]

vim /etc/httpd/conf/httpd.conf #change the listening port to 80

iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 8080
iptables -I INPUT 1 -p tcp -m state --state NEW -m tcp --dport 8080 -j ACCEPT #1=line number, -m=match

iptables -t nat -A PREROUTING -p tcp --dport 8080 -j DNAT --to-destination 172.31.33.72:80
iptables -t nat -A POSTROUTING -j MASQUERADE #replace source address with front facong servers own address
iptables -I FORWARD -p tcp -d 172.31.33.72 --dport 80 -m state --state NEW -j ACCEPT
iptables -I FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -I INPUT -p tcp -m state --state NEW --dport 80 -j ACCEPT
echo 1 > /proc/sys/net/ipv4/ip_forward



[ Firewalld ]

{ Initial testing }
vim /etc/httpd/conf/httpd.conf #change the listening port to 8080
firewall-cmd --add-port=8080/tcp
firewall-cmd --add-forward-port=port=80:proto=tcp:toport=8080

{ Port Forwarding }
firewall-cmd --remove-forward=port=80:proto=tcp:toport=8080:toaddr=
firewall-cmd --add-forward-port=port=8080:proto=tcp:toport=80:toaddr=172.31.33.72
firewall-cmd --add-masquerade


