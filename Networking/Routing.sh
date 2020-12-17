#!/bin/bash




echo "1" > /proc/sys/net/ipv4/ip_forward #for using the box as a router

echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf #same as above



[ Routing Table ]

route #routing table
route -n
routel #full routing table
ip route #new command



[ Rules ]

ip route add 1.1.1.1 via 10.1.1.3 dev eth 0

ip route add prohibit 1.1.1.1
 
ip route flush 1.1.1.1 #remove the above rule




