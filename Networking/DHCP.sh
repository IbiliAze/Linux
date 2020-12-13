#!/bin/bash




[ DHCP Server ]



[ DHCP Client ]

cat /var/lib/dhcp/dhclient.leases
cat /etc/dhcp/dhclient.conf #for Ubuntu

ss -lnup | grep dhclient #see if the client is listening UDP port 68

dhclient -r #release IP
dhclient #restart dhclient



