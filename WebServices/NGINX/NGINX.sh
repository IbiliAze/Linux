#!/bin/bash




echo '127.0.0.1 www.mydomain.com' >> /etc/hosts
mkdir /usr/share/nginx/html/mydomain
echo "guru" > /usr/share/nginx/html/mydomain/index.html

cp /usr/share/nginx/html/404.html /usr/share/nginx/html/mydomain/ #optionally move the error sites to the root directory and customise
cp /usr/share/nginx/html/50x.html /usr/share/nginx/html/mydomain/ 

vim /etc/nginx/nginx.conf 
>http
    >server
        >server_name www.mydomain.com;
        >listen       [::]:80 default_server; #can optionally comment out to not listen on IPv6
        >root         /usr/share/nginx/html/mydomain; #change default document root for index.html
        >error_page  404 /404.html;
            >location = /mydomain/40x.html { #if custom error sites
        >error_page 500 502 503 504 /50x.html;
            >location = /mydomain/50x.html {
systemctl restart nginx
curl www.mydomain.com



[ Reverse Proxy ]

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
