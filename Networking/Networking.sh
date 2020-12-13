#!/bin/bash




[ Interfaces ]

{ifconfig}
ifconfig

ifconfig -a #-a=all, all detected devices

ifconfig eth0:1 10.1.1.1 netmask 255.255.255.0 #create a dummy virtual interface, using eth0 as a blueprint

ifconfig eth0:1 #view the interface config

ifconfig eth0:1 192.168.0.100 netmask 255.255.255.0 broadcast 192.168.0.255 #setup/change an IP address

ifconfig eth0:1 down 

ifconfig eth0:1 up

ifconfig eth0:1 promisc #silent packet capture, will STDERR

ifconfig eth0:1 -promisc #turn of promiscious


{ip}
{New vs Old}
ip neigh <== arp

ip a <== ifconfig

ip maddr <== ipmaddr

ip tunnel <== iptunnel

ip route <== route

echo '''DEVICE=eth0:1
IPADDR=10.1.1.23
NETMASK=255.255.255.0
BROADCAST=10.1.1.255
ONBOOT=yes
BOOTPROTO=none''' >> /etc/sysconfig/network-scripts/ifcfg-eth0:1 #interface config file for CentOS
systemctl restart network

journalctl -xe -u network #troubeshooting


{Commands}
ip a

ip a add 10.1.1.1/24 dev eth0

ip a s eth0 #show interface

ip link set dev eth0 ip #turn on the interface

ip maddr #multicast address



[ Sockets & Ports ]

ss -an #see all open connections

ss -atp #see all TCP open connections

netstat #same as above

netstat -at #TCP

netstat -l #-l=listening


{netcat}
nc -l 80 #listen at port 80

nc -l -k 80 #-k=continue listening after client disconnects

nc -l -k -u 80 #-u=UDP

nc -l -w 30 80 #-w=timeout

nc 10.1.1.1 80 #connect from client (for testing the commands above)



[ Routing & ARP Tables ]

route #routing table

routel #full routing table

netstat -r #same as above

ip route #new command

arp #ARP table

ip neigh #ARP table



[ DHCP ]

sudo dhclient #turn on DHCP client

sudo dhclient -r #-r release, reset DHCP

sudo systemctl restart network #new restart command for Systemd

sudo vim /etc/sysconfig/network-scripts/ifcfg-ens33 #edit interface ethernet 33 for centos
    > BOOTPROTO="none"
    > IPADDR0='10.12.42.122'
    > PREFIX0=16
    > GATEWAY0="10.1.1.1"
    > DEFROUTE=yes



[ Troubleshooting ]

tracepath 8.8.8.8 #new version of traceroute

nslookup www.google.com #DNS test

nslookup www.google.com 1.1.1.1 #test DNS with 1.1.1.1 

dig www.youtube.com #verbose DNS test

sudo tcpdump #traffic analyser

sudo tcpdump -i ens33 #-i interface

sudo tcpdump -i ens33 > data.txt

nc www.google.com 443 #netcat, L7 test
    > GET #HTTP GET Request
