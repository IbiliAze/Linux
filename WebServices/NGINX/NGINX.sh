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

setsebool -P http_can_network_connect 1



[ SSL / TLS / HTTPS ]

mkdir /etc/nginx/ssl
openssl req -x509 -nodes -days 365 \ 
    -newkey rsa:2048 -keyout /etc/nginx/ssl/private.key \
    -out /etc/nginx/ssl/public.pem #-nodes=don't encrypt the output key
echo "server {
        listen 80 default_server;
        listen [::]:80 default_server;

        listen 443 ssl;
        ssl_certificate /etc/nginx/ssl/public.pem;
        ssl_certificate_key /etc/nginx/ssl/private.key;

        root /var/www/html;

        index index.html index.htm index.nginx-debian.html;

        server_name _;
}" > /etc/nginx/conf.d/default.conf
nginx -t
nginx -s reload
curl https://localhost -k #-k=ignore self-signed certificate error 


{Improving SSL Config}
echo "server {
        listen 80 default_server;
        listen [::]:80 default_server;

        listen 443 ssl;
        ssl_certificate /etc/nginx/ssl/public.pem;
        ssl_certificate_key /etc/nginx/ssl/private.key;

        ssl_session_timeout 1d;
        ssl_session_cache shared:SSL:50m;
        ssl_session_tickets off; #keep the SSL session on the server, rather than the client
        ssl_protocols TLSv1.2;
        ssl_ciphers 'TLS_AES_128_GCM_SHA256:TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256';
        ssl_prefer_server_ciphers on;
        add_header Strict-Transport-Security max-age=15768000; #forcing the client to HTTPS
        ssl_stapling on; #pre-fetch the certificate validation

        root /var/www/html;

        index index.html index.htm index.nginx-debian.html;

        server_name _;
}" > /etc/nginx/conf.d/default.conf


{Redirect to HTTPS}
echo "server {
        listen 80 default_server;
        server_name _;
        return 301 https://$host$request_uri;
}


server {
        listen 443 ssl;
        ssl_certificate /etc/nginx/ssl/public.pem;
        ssl_certificate_key /etc/nginx/ssl/private.key;

        root /var/www/html;

        index index.html index.htm index.nginx-debian.html;

        server_name _;
}" > /etc/nginx/conf.d/default.conf
nginx -t
nginx -s reload
curl localhost | grep 301
curl localhost -L -k #-L=follow redirects



[ ModSecurity ] #OWASP

mkdir /etc/nginx/modsecurity
cd /etc/nginx/modsecurity
git clone https://github.com/spiderlabs/owasp-modsecurity-crs.git
cd owasp-modsecurity-crs
cp crs-setup.conf{.example,}
cp rules/REQUEST-900-EXCLUSION-RULES-BEFORE-CRS.conf{.example,}
cp rules/RESPONSE-999-EXCLUSION-RULES-AFTER-CRS.conf{.example,}



[ Redirecting ]

echo "server {
        listen 80 default_server;
        listen [::]:80 default_server;

        listen 443 ssl;
        ssl_certificate /etc/nginx/ssl/public.pem;
        ssl_certificate_key /etc/nginx/ssl/private.key;

        rewrite ^(/.*)\.html(\?.*)?$ $1$2 redirect;
        rewrite ^/(.*)/$ /$1 redirect;

        root /var/www/html;

        index index.html index.htm index.nginx-debian.html;

        server_name _;
}" > /etc/nginx/conf.d/default.conf #will remove the .html string, second will remove the trailing /
nginx -t
nginx -s reload


{Redirect to HTTPS}
echo "server {
        listen 80 default_server;
        server_name _;
        return 301 https://$host$request_uri;
}


server {
        listen 443 ssl;
        ssl_certificate /etc/nginx/ssl/public.pem;
        ssl_certificate_key /etc/nginx/ssl/private.key;

        root /var/www/html;

        index index.html index.htm index.nginx-debian.html;

        server_name _;
}" > /etc/nginx/conf.d/default.conf
nginx -t
nginx -s reload
curl localhost | grep 301
curl localhost -L -k #-L=follow redirects



[ Modules ]

nginx -V 2>&1 | tr -- - '\n' | grep _module #see enabled compiled modules

yum group install 'Development Tools'



[ Reverse Proxy ]

echo "server {
        listen 80 default_server;
        listen [::]:80 default_server;

        root /var/www/html;

        index index.html index.htm index.nginx-debian.html;

        server_name myrp.com;
        location / {
            proxy_pass http://10.253.104.62:80;

            proxy_http_version 1.1;

            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for; #forward chain of IP address to the servers
            proxy_set_header X-Real-IP $remote_addr; #forward real IP address to the servers
            proxy_set_header Upgrade $http_upgrade; #for Node.JS websocket.io
            proxy_set_header Connection "upgrade"; #same as above
        }
}" > /etc/nginx/conf.d/default.conf
nginx -t
nginx -s reload
curl localhost


#Nodes
echo $(ip a) > /var/www/html/index.html



[ Load Balancing ]

{Round-Robin}
echo "upstream myservers {
        server 10.253.104.62:80;
        server 10.253.104.24:80;
}

server {
        listen 80 default_server;
        listen [::]:80 default_server;

        root /var/www/html;

        index index.html index.htm index.nginx-debian.html;

        server_name myrp.com;
        location / {
            proxy_pass http://myservers;
            proxy_http_version 1.1;

            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for; #forward chain of IP address to the servers
            proxy_set_header X-Real-IP $remote_addr; #forward real IP address to the servers
            proxy_set_header Upgrade $http_upgrade; #for Node.JS websocket.io
            proxy_set_header Connection "upgrade"; #same as above
        }

}" > /etc/nginx/conf.d/default.conf
nginx -t
nginx -s reload
curl localhost
curl --header "Host: 10.253.104.62:80" localhost


{Weighted}
echo "upstream myservers {
        server 10.253.104.62:80 weight=2;
        server 10.253.104.24:80;
}" > /etc/nginx/conf.d/default.conf #default weight is 1


{Hash}
echo "upstream myservers {
        hash $request_uri;
    
        server 10.253.104.62:80;
        server 10.253.104.24:80;
}" > /etc/nginx/conf.d/default.conf


{Active-Passive Failover}
echo "upstream myservers {
        server 10.253.104.62:80;
        server 10.253.104.24:80 backup;
}" > /etc/nginx/conf.d/default.conf


{Passive Fail Check} 
echo "upstream myservers {
        server 10.253.104.62:80 max_fails=3 fail_timeout=20s; #3 failures in 20 seconds
        server 10.253.104.24:80 max_fails=3 fail_timeout=20s;
}" > /etc/nginx/conf.d/default.conf #checks for fails, if failed the server will be marked unavailable


{IP-Hash}
echo "upstream myservers {
        ip_hash;

        server 10.253.104.62:80;
        server 10.253.104.24:80;
}" > /etc/nginx/conf.d/default.conf


{Least Connected}
echo "upstream myservers {
        least_conn;

        server 10.253.104.62:80;
        server 10.253.104.24:80;
}" > /etc/nginx/conf.d/default.conf



[ Logging ]

{Log Formats}
echo step 1
echo "http {

        log_format  myformat1       '$host $remote_addr - $remote_user [$time_local] "$request" '
                                    '$status $body_bytes_sent "$http_referer " '
                                    '"$http_user_agent" "$http_x_forwarded_for" ';
}" >> /etc/nginx/nginx.conf #basic format with the host specified

echo step 2
echo "server {
        listen 80 default_server;
        listen [::]:80 default_server;

        access_log /var/log/nginx/access.log myformat1;

        root /var/www/html;

        index index.html index.htm index.nginx-debian.html;

        server_name myrp.com;
        location / {
           proxy_pass http://myservers;

           proxy_http_version 1.1;

           proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for; #forward chain of IP address to the servers
           proxy_set_header X-Real-IP $remote_addr; #forward real IP address to the servers
           proxy_set_header Upgrade $http_upgrade; #for Node.JS websocket.io
           proxy_set_header Connection "upgrade"; #same as above
        }
}" > /etc/nginx/conf.d/default.conf #apply the format on a virtual host
nginx -t
nginx -s reload
curl localhost
less /var/log/nginx/access.log


{Syslog}
echo "server {
        listen 80 default_server;
        listen [::]:80 default_server;

        access_log syslog:server=unix:/dev/log myformat1;

        root /var/www/html;

        index index.html index.htm index.nginx-debian.html;

        server_name myrp.com;
        location / {
           proxy_pass http://myservers;
    
           proxy_http_version 1.1;

           proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for; #forward chain of IP address to the servers
           proxy_set_header X-Real-IP $remote_addr; #forward real IP address to the servers
           proxy_set_header Upgrade $http_upgrade; #for Node.JS websocket.io
           proxy_set_header Connection "upgrade"; #same as above
        }

}" > /etc/nginx/conf.d/default.conf
nginx -t
nginx -s reload
curl localhost
less /var/log/messages #CentOS
less /var/log/syslog #Ubuntu



[ Worker Connections ]

echo "worker_processes auto;" >> /etc/nginx/nginx.conf #number of CPU cores allocated

su -s /bin/sh -c "ulimit -Hn" #number of active connections allowed by the server (hard limit)
su -s /bin/sh -c "ulimit -Sn" #number of active connections allowed by the server (soft limit)
echo "events {
        worker_connections 1024;
}" >> /etc/nginx/nginx.conf

echo "upstream myservers {
        server 10.253.104.62:80;
        server 10.253.104.24:80;

        keepalive 32; #connections
}

server {
        listen 80 default_server;
        listen [::]:80 default_server;

        root /var/www/html;

        index index.html index.htm index.nginx-debian.html;

        server_name myrp.com;
        location / {
            proxy_pass http://myservers;
            proxy_http_version 1.1; #must be at least 1.1 for keepalives

            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for; #forward chain of IP address to the servers
            proxy_set_header X-Real-IP $remote_addr; #forward real IP address to the servers
            proxy_set_header Upgrade $http_upgrade; #for Node.JS websocket.io
            proxy_set_header Connection "upgrade"; #same as above, must be set for keepalives
        }

}" > /etc/nginx/conf.d/default.conf #keepalive connections for load balancing / reverse proxy
nginx -t
nginx -s reload



[ Troubleshooting ]

systemctl stop firewalld









