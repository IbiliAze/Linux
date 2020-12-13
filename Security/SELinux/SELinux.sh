#!/bin/bash


[ Installation ]

sudo apt install -y selinux selinux-utils selinux-basics auditd audispd-plugins
sudo apt install -y policycoreutils-python #for semanage
sudo reboot
sestatus
getenforce #see the enforce method, same as above



[ setenforce ]

sudo setenforce permissive #doesn't block but logs
sudo setenforce enforcing #blocks unauthorized users



[ Config Files ]

sudo vim /etc/selinux/config #selinux config file, changes are permanent
reboot

sudo chcon -Rv --type=httpd_sys_content_t /website #-R=recursive, -v=verbose, change context / add label, permanent but can be reverted with restorecon

sudo semanage fcontext -a -t httpd_sys_content_t /website #-a=adding, -t=type, fcontext=file context
sudo restorecon -Rv /website #Policy-Based, same as above, but cannot be reverted with restorecon



[ Config Ports ]

sudo semanage port -a -t http_port_t -p tcp 8080 #allow apache use HTTP with port 8080

sudo semanage port -l #list of services to port mappings



[ Logs ]

sudo tail /var/log/audit/audit.log #selinux permissive logs
tail /var/log/syslog -f #selinux logs for Ubuntu



[ Labels ]

ls -lZ #see the selinux labels
sudo ls -lZ /var/log/audit #see the selinux labels
ps auxZ | grep crond #labels for crond for example



[ Troubleshooting ]

sudo restorecon -Rv /website #revert the changes on the context/label



[ Example ]

{Change NGINX root folder with SELinux set to enforcing}
sudo mkdir /website
sudo vim /etc/nginx/sites-enabled/default
> change "root /var/www/html;" to "/website;"
sudo chcon -Rv --type=httpd_sys_content_t /website

