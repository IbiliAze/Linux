#!/bin/bash



[ DNS ]
 
getent ahosts latoys.com #resolve to IP

cat /etc/nsswitch.conf | grep dns #order of name resolution

dig -d www.google.com #DNS info

dig -d www.acloudguru.com +trace | awk 'length($0)<60' #tracing a DNS query
 
sudo vim /etc/resolv.conf #DNS servers

sudo vim /etc/hosts #overwrite DNS hosts

cat /etc/hostname #hostname of the device (after reboot it doesn't apply)

sudo hostnamectl set-hostname ubuntuuu #change the name permanently (reopen the terminal for changes to take effect)



[ dig ]

dig -d www.google.com #DNS info

dig -d www.acloudguru.com +trace | awk 'length($0)<60' #tracing a DNS query

dig @localhost cnn.com #nslookup with localhost as the name server



[ BIND ]

systemctl start named
systemctl enable named

named-checkconf #pre-flight named config check

named-checkzone mydomain.com /var/named/fwd.mydomain.com.db #pre-flight forward zone config check
named-checkzone 10.253.104.62 /var/named/104.253.10.db #pre-flight reverse zone config check

dig @localhost named.mydomain.com #nslookup check

nslookup dns.mydomain.com localhost #CNAME check

cat /etc/rndc.key #pre-generated key file

rndc reload #reload config and zones

rndc flush #flush all cached TTLs

rndc flush google.com #flush a specific domain cached TTL


{Generate new rndc key}
rm /etc/rndc.key
systemctl stop named
rndc-confgen -r /dev/urandom > /etc/rndc.conf #-r=random, generate key
echo '''key "rndc-key" {
       algorithm hmac-md5;
       secret "9Cut19kH9FXeSUvKyUWZjQ==";
};

controls {
       inet 127.0.0.1 port 953
               allow { 127.0.0.1; } keys { "rndc-key"; };
};''' > /etc/named.conf #from <commented lines> in /etc/rndc.conf
chgrp named /etc/rndc.conf
chmod 640 /etc/rndc.conf
systemctl start named
rndc reload


{Zones}
chgroup named /var/named/fwd.mydomain.com.db
chgroup named /var/named/104.253.10.db

named-checkzone mydomain.com /var/named/fwd.mydomain.com.db #pre-flight forward zone config check

named-checkzone 10.253.104.62 /var/named/104.253.10.db #pre-flight reverse zone config check

dig @localhost named.mydomain.com #nslookup check

nslookup dns.mydomain.com localhost #CNAME check



[ DNSSEC ]

yum install -y rng-tools
dnssec-keygen -a RSASHA1 -b 1024 -n ZONE mydomain.com
rngd -r /dev/urandom -o /dev/random -b
dnssec-keygen -a RSASHA256 -b 2048 -n ZONE -f KSK mydomain.com
dnssec-keygen -a RSASHA256 -b 1024 -n ZONE mydomain.com
cp /var/named/fwd.mydomain.com.db .
dnssec-keygen -a RSASHA256 -b 1024 -n ZONE mydomain.com



{Split DNS}


{chroot Jail}
echo '-t /chroot/named' >> /etc/sysconfig/named #make sure named sees that DNS config should be loaded onto a chroot jail
mkdir /chroot
mkdir -p /chroot/{named/dev,named/etc,named/var/named,named/var/run}
cp /etc/named.conf /chroot/named/etc/
cp /etc/localtime /chroot/named/etc/
cp -rf /var/named/* /chroot/named/var/named/
chown named:named -R /chroot/named/
mknod /chroot/named/dev/random c 1 8
mknod /chroot/named/dev/null c 1 3
chmod 666 /chroot/named/dev/*
systemctl start named
dig @localhost mailprod.mydomain.com













