#!/bin/bash




echo '127.0.0.1 www.mydomain.com' >> /etc/hosts
mkdir /usr/share/nginx/html/mydomain
echo "guru" > /usr/share/nginx/html/mydomain/index.html

cp /usr/share/nginx/html/404.html /usr/share/nginx/html/mydomain/ #optionally move the error sites to the root directory and customise
cp /usr/share/nginx/html/50x.html /usr/share/nginx/html/mydomain/ 

nginx -t #-t=test, test config error

nginx -s reload #-s=signal, same as 'systemctl restart nginx'



[ Config Files ]

{nginx.conf}
vim /etc/nginx/nginx.conf #main server config
echo "error_log     /var/log/nginx/error.log warn" >> /etc/nignx/nginx.conf #warn=log level, log file
echo "http {
        sendfile on; ==> WILL ALLOW THE USE OF sendfile SYSTEM CALL 
        tcp_nopush on;
        tcp_nodelay on;
        keepalive_timeout 65;
        types_hash_max_size 2048;

        include /etc/nginx/mime.types; ==> INCLUDE ANOTHER CONFIG FILE IN THIS CONTEXT
        default_type application/octet-stream; ==> IF ABOVE ISN'T SPECIFIED

        ssl_protocols TLSv1 TLSv1.1 TLSv1.2 TLSv1.3; # Dropping SSLv3, ref: POODLE
        ssl_prefer_server_ciphers on;

        access_log /var/log/nginx/access.log;
        error_log /var/log/nginx/error.log;

        gzip on;

        include /etc/nginx/conf.d/*.conf; ==> INCLUDE ALL CONFIG FILES IN /etc/nginx/conf.d/ ENDING IN .conf
        include /etc/nginx/sites-enabled/*; ==> INCLUDE ALL CONFIG FILES IN /etc/nginx/sites-enabled
}" >> /etc/nignx/nginx.conf


{conf.d/*.conf}
vim /etc/nginx/conf.d/*.conf #virtual hosts



[ Basic Auth ]

apt install -y apache2-utils #Ubuntu
yum install -y httpd-tools #CentOS
echo "server {
        listen 80 default_server;
        listen [::]:80 default_server;
        
        root /var/www/html;        

        index index.html index.htm index.nginx-debian.html;

        server_name _;

        location /admin.html {
                auth_basic "Login Required Message";
                auth_basic_user_file /etc/nginx/.htpasswd;

        }
}" >> /etc/nginx/conf.d/default.conf
htpasswd -c /etc/nginx/.htpasswd admin #-c=create, admin=user name
nginx -t
nginx -s reload
echo admin page > /var/www/html/admin.html
curl localhost/admin.html | grep 401
curl localhost/admin.html -u admin:cisco -I | grep 200



[ Error Handling ]

echo "server {
        listen 80 default_server;
        listen [::]:80 default_server;

        root /var/www/html;

        index index.html index.htm index.nginx-debian.html;

        server_name _;

        error_page 404 /404.html;
        error_page 500 501 502 503 504 /50x.html;
}" >> /etc/nginx/conf.d/default.conf
echo 404 > /var/www/html/404.html
echo internal error > /var/www/html/50x.html
nginx -t
nginx -s reload
curl localhost/doesexist.html #404 check



[ Virtual Hosts ]

{Name Based}
echo "server {
        listen 80;
        listen [::]:80;

        root /var/www/html/mydomain;

        index index.html;

        server_name mydomain.com www.mydomain.com;
}" >> /etc/nginx/conf.d/mydomain.com.conf
mkdir /var/www/html/mydomain/
echo mydomain > /var/www/html/mydomain/index.html
nginx -t
nginx -s reload
curl --header "Host: mydomain.com" 127.0.0.1 #curl using this server, don't search mydomain.com over the internet



[ SELinux Permission Error ]

semanage fxontext -l | grep /usr/share/nginx/html #-l=label, see the labels
semanage fxontext -l | grep /var/www/html #see the labels -> httpd_sys_content_t
semanage fcontext -a -t #-a=add, -t=type/tag httpd_sys_content_t '/mydir(/.*)?'
restorecon -R /mydir #-R=recursive, -v=verbose



[ SSL / TLS / HTTPS ]

mkdir /etc/nginx/ssl
openssl req -x509 -nodes -days 365 \ 
    -newkey rsa:2048 -keyout /etc/nginx/ssl/private.key \
    -out /etc/nginx/ssl/public.pem #-nodes=don't encrypt the output key



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
