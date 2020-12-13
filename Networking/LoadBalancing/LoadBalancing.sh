#!/bin/bash



[ HAProxy ]

#Load Balancer
sudo su
yum install haproxy -y
systemctl start haproxy
firewall-cmd --permanent --add-service=http
firewall-cmd --reload
vim /etc/haproxy/haproxy.cfg #config files provided in this directory
systemctl restart haproxy
ss -lntp
for i {1..10}; do curl localhost; done
 
#Nodes
sudo su
vim /etc/httpd/conf/httpd.conf #change listen to 8080
systemctl restart httpd
ss -lntp
firewall-cmd --permanent --add-port=8080/tcp
firewall-cmd --reload
curl localhost:8080



[ NGINX ]

#Load Balancer
sudo su
yum install -y epel-release #if failed on AWS amazon-linux-extras install epel
yum install -y nginx        #if failed on AWS amazon-linux-extras install nginx1
firewall-cmd --permanent --add-service=http
firewall-cmd --reload
systemctl start nginx
vim /etc/nginx/nginx.conf #config files provided in this directory
systemctl restart nginx
ss -lntp
for i {1..10}; do curl localhost; done

#Nodes
sudo su
vim /etc/httpd/conf/httpd.conf #change listen to 8080
systemctl restart httpd
ss -lntp
firewall-cmd --permanent --add-port=8080/tcp
firewall-cmd --reload
curl localhost:8080

