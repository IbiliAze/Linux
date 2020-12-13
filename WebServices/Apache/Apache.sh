#!/bin/bash



[ Modules ]

/httpd/modules/ #modules

/etc/httpd/conf.modules.d/ #loading modules files


{Perl}
yum install -y perl mod_perl
mkdir /var/www/html/perl-cgi

echo '''<Directory /var/www/html/perl-cgi>
    AllowOverride All
    SetHandler perl-script
    PerlHandler ModPerl::Registry
    PerlOptions +ParseHeaders
    Options ExecCGI
    Order allow,deny
    Allow from all
</Directory>''' >> /etc/httpd/conf/httpd.conf
vim /var/www/html/perl-cgi/index.pl #perl script
systemctl restart httpd


{PHP}
yum install -y php
vim /var/www/html/index.php #PHP script
systemctl restart httpd



[ HTTPS ]

yum install -y mod_ssl #apache SSL module


{Private key to be signed by a trusted CA}
ll /etc/httpd/conf.modules.d/00-ssl.conf #the loaded SSL module
openssl genrsa -des3 -out mydomain.key 2048 #private key
openssl req -new -key mydomain.key -out mydomain.csr #-new=new cert, create a Certificate Signing Request


{Self-Signed Certificate}
yum install -y openssl-perl #for creaing a CA
find / -name CA.pl #find the perl script location
/usr/bin/CA.pl -newca #create a new CA
/usr/bin/CA.pl -newreq
/usr/bin/CA.pl -sign #self-signed cert


mkdir /etc/httpd/ssl
cp newkey.pem /etc/httpd/ssl/mydomain.com-private.pem
cp newcert.pem /etc/httpd/ssl/mydomain.com-selfcert.pem
echo '''SSLCertificateFile /etc/httpd/ssl/mydomain.com-selfcert.pem
SSLCertificateKeyFile /etc/httpd/ssl/mydomain.com-private.pem''' >> /etc/httpd/conf/httpd.conf
echo '''SSLCertificateFile /etc/httpd/ssl/mydomain.com-selfcert.pem
SSLCertificateKeyFile /etc/httpd/ssl/mydomain.com-private.pem''' >> /etc/http
systemctl restart httpdd/conf.d/ssl.conf
 


[ Security ]

{Authentication:htpasswd}
mkdir /var/www/html/secure
echo "secure web" > /var/www/html/secure/secure.html
htpasswd -c /etc/httpd/passwdfile user1 #-c=create password file
    >New password:
htpasswd /etc/httpd/passwdfile user2 #remove the -c flag to add new users
    >New password:
echo '''<Directory "/var/www/html/secure">
        AuthName "Secure Folder"
        AuthType Basic
        AuthUserFile /etc/httpd/passwdfile
        Require valid-user
</Directory>''' >> /etc/httpd/conf/httpd.conf
systemctl restart httpd
curl localhost/secure/secure.html


{Authentication:htaccess} #Gives you the ability to alter the Content-Types, redirects & additional flexibility
mkdir /var/www/html/secure2
echo "second secure site" > /var/www/html/secure2/secure.html
echo '''AuthName "Secure 2 Folder"
AuthType Basic
AuthUserFile /etc/httpd/passwdfile
Require valid-user''' > /var/www/html/secure2/.htaccess
echo '''<Directory "/var/www/html/secure2">
        AllowOverride AuthConfig
</Directory>''' >> /etc/httpd/conf/httpd.conf
systemctl restart httpd
curl localhost/secure2/secure.html



[ Virtual Hosts ]

{Named-Based}
mkdir /var/www/html/mydomain
mkdir /var/www/html/extradomain
echo "this is www.mydomain.com" > /var/www/html/mydomain/index.html
echo "this is www.mydomain.com" > /var/www/html/extradomain/index.html
echo '''10.253.104.62 www.mydomain.com
10.253.104.62 www.extradomain.com''' >> /etc/hosts
echo '''NameVirtualHost 10.253.104.62

<VirtualHost 10.253.104.62>
        ServerName www.mydomain.com
        DocumentRoot /var/www/html/mydomain
</VirtualHost>

<VirtualHost 10.253.104.62>
        ServerName www.extradomain.com
        DocumentRoot /var/www/html/extradomain
</VirtualHost>''' >> /etc/httpd/conf/httpd.conf
systemctl restart httpd


{IP-Based}
mkdir /var/www/html/mydomain
mkdir /var/www/html/extradomain
echo "this is www.mydomain.com" > /var/www/html/mydomain/index.html
echo "this is www.mydomain.com" > /var/www/html/extradomain/index.html
mkdir /var/log/httpd/mydomain
mkdir /var/log/httpd/extradomain
echo '''<VirtualHost www.mydomain.com>
        ServerAdmin admin@mailprod.mydomain.com
        DocumentRoot /var/www/html/mydomain
        ServerName www.mydomain.com
        ErrorLog /var/log/httpd/mydomain/error_log
</VirtualHost>

<VirtualHost www.extradomain.com>
        ServerAdmin admin@mailprod.extradomain.com
        DocumentRoot /var/www/html/extradomain
        ServerName www.extradomain.com
        ErrorLog /var/log/httpd/extradomain/error_log
</VirtualHost>''' >> /etc/httpd/conf/httpd.conf 
systemctl restart httpd



[ Squid ]

yum install -y squid

systemctl start squid
systemctl enable squid

ss -lntp | grep 3128
telnet <private IP> 3128 #default squid listening port

export http_proxy=http://10.253.104.62:3128 #make sure the system uses the proxy server for external connections 
curl yahoo.com -I -L #-I=headers only, -L=follow redirects, check the external connection 




















