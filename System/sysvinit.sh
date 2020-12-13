#!/bin/bash


cd /etc/rc.d #what sysvinit runs when running
    \ rc0.d #showdown
    \ rc6.d #reboot
    \ rc1-5.d #depends on distro
sudo chkconfig  #deafult 3 and 5
sudo chkconfig httpd on #turn on httpd for run level 3 and 5
sudo chkconfig --level 234 httpd on #http on run level 2, 3 and 4
chkconfig --list
sudo service httpd start #temporarily start (until reboot)
service httpd status
sudo init 3 #change run level to 3

