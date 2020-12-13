#!/bin/bash


#Server
sudo su
yum install -y epel-release #if failed on AWS amazon-linux-extras install epel
yum install -y openvpn
firewall-cmd --permanent --add-port=1192/tcp #for TCP, one or the other
firewall-cmd --permanent --add-port=1192/udp #for UDP, one or the other
firewall-cmd --permanent --add-masquarade
firewall-cmd --reload
yum install -y easy-rsa 
mkdir -p /etc/openvpn/easy-rsa
cd /etc/openvpn/easy-rsa
PATH=$PATH:/usr/share/easy-rsa/3.0.8/
easyrsa init-pki
easyrsa build-ca
easyrsa gen-dh #diffie-helman
easyrsa gen-req server nopass
easyrsa sign-req server server
easyrsa gen-req client nopass
easyrsa sign-req server client
cd /etc/openvpn
openvpn --genkey --secret pfs.key
cat /usr/share/doc/openvpn-2.4.9/sample/sample-config-files/server.conf | egrep -v "(^#.*|^$)" > server2.conf
cat server2.conf | grep -v '^;' > server.conf
rm server2.conf




