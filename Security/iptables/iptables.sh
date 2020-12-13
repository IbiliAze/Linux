#!/bin/bash


[ Installation ]

sudo iptables --list #see if you have the iptables utilities
sudo apt install -y iptables-services
sudo yum install -y conntrack-tools


[ Systemctl ]

sudo systemctl stop firewalld
sudo systemctl mask firewalld # any app that triggers firewalld will be forwarded to /dev/null
sudo systemctl enable --now iptables



[ Rules ]

sudo iptables --list-rules #config stored on disk

sudo iptables --list #see the acl rules

sudo iptables -L #-L=list

sudo iptables -L --line-numbers

sudo iptables -L INPUT #INPUT chain for filter table

sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT #-A=append/CHAIN, created in RAM

sudo iptables -A INPUT -p tcp --dport ssh -s 5.193.32.123 -j REJECT #created in RAM


{Filter Table}
sudo iptables -t filter -L

sudo iptables -L INPUT #INPUT chain for filter table

sudo iptables -t filter -A INPUT -p tcp --dport 22 -j ACCEPT #-t=table

sudo iptables -t filter -I INPUT 5 -s 10.0.1.0/23 -j REJECT #-I=insert, 5=line 5, -s=source



[ Saving ]

sudo iptables-save #stdout to see how it would look in disk

sudo cat /etc/sysconfig/iptables #where the config is saved on disk, forward it to the config
sudo iptables-save > /etc/sysconfig/iptables #write the iptables to disk on CentOS
sudo iptables-save > /etc/iptables/rules.v4 #write the iptables to disk on Ubuntu
                     /etc/iptables.rules #try this if it fails
                     /run/xtables.lock #try this if it fails

sudo iptables-save | tee etc/sysconfig/iptables #same as above and STDOUT

sudo iptables -F #flush the config from ram and load from disk

systemctl restart iptables #on the safe side



[ Misc ]

sudo iptables -vnL --line #packet count, statistics of the rules, think of: show ip access-lists

sudo watch -n 0.5 iptables -vnL #0.5=every 0.5 seconds,  watch -n 0.5 iptables -vnLlive dashboard simulation

sudo cat /proc/net/nf_conntrack #connection tracking

sudo conntrack -L #-L=list, same as above

sudo conntrack -L -p tcp --dport 80

sudo conntrack -E -p tcp --dport 80 #-E=event, live



[ Chains ]

##                                                                                     ##
##                   PRE-ROUTING                              INPUT                    ##
##                                                                                     ##
## ==>     raw -> con-track -> mangle -> NAT     ==>     mangle -> filter    ==>       ##
##                                       .                                             ##
##                                       .                                             ##
##                                    mangle                                           ##
# NIC                     FORWARD        .                                          PID #
##                                    filter                                           ##
##             <-  <-  <-  <-  <-  <-  <-.                                             ##     
##            .                                                                        ##
## <==   NAT <- mangle   <==   filter <- NAT <- mangle <- con-track <- raw   <==       ##
##                                                                                     ##
##         POST_ROUTING                   OUTPUT                                       ##
##                                                                                     ##



[ Tables ]

# Filter

# NAT

# MANGLE        --> altering the headers of packets, e.g TTL field

# SECURITY      --> set security contexts on packets / connections for SELinux

# RAW           --> NEW, RELATED, ESTABLISHED



[ Chains ]

# PRE-ROUTING

# INPUT

# FORWARD

# POST-ROUTING

# OUTPUT


[ States ]

# NEW           --> very first packet of the connection

# RELATED       --> packets related with connetion already in the system but not an existing connection (FTP data, relying on FTP control)

# ESTABLISHED   --> packets part of an existing connection (SYN/ACK)

# INVALID       --> packets without a state (network error)

# UNTRACKED     --> packets exempt from connection tracking  

# SNAT          --> source NAT

# DNAT          --> destination NAT














