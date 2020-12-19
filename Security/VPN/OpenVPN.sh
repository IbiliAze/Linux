#!/bin/bash


#Server
sudo su

echo step 1
yum install -y epel-release #if failed on AWS amazon-linux-extras install epel
yum install -y openvpn easy-rsa

echo step 2
firewall-cmd --permanent --add-port=1192/tcp #for TCP, one or the other
firewall-cmd --permanent --add-port=1192/udp #for UDP, one or the other
firewall-cmd --permanent --add-masquarade
firewall-cmd --reload

echo step 3
mkdir -p /etc/openvpn/easy-rsa
cd /etc/openvpn/easy-rsa

echo step 5
export PATH=$PATH:/usr/share/easy-rsa/3.0.8/

echo step 6
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




