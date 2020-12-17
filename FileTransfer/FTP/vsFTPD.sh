#!/bin/bash



yum install -y vsftpd ftp

systemctl start vsftpd


[ Users ]

cat /etc/vsftpd/ftpusers #users who can't use FTP

cat /etc/vsftpd/user_list 

echo '''anonymous_enable=YES''' >> /etc/vsftpd/vsftpd.conf #anon user can login
 
echo '''anon_max_rate=1000''' >> /etc/vsftpd/vsftpd.conf #limit in bytes for bandwidth

echo '''userlist_enable=YES''' >> /etc/vsftpd/vsftpd.conf #define a file to allow or block user access

echo '''userlist_deny=YES''' >> /etc/vsftpd/vsftpd.conf #users in the user_list file are denied access
echo '''userlist_deny=NO''' >> /etc/vsftpd/vsftpd.conf #only users in the user_list file are allowed access



[ Banner ]

echo '''banner_file=/etc/vsftpd/bannerfile''' >> /etc/vsftpd/vsftpd.conf #login banner

echo '''ftpd_banner=Hello''' >> /etc/vsftpd/vsftpd.cond #same as above
