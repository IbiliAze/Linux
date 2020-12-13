#!/bin/bash


cat /etc/crontab #first main cron table (text file)
ls /etc/cron.d #secondary cron (folder)
sudo ls /var/spool/cron #user cron tab
crontab -e #edit my table, will create a /var/spool/cron/{username} file
    > 55 14 29 6 1 ibi /usr/bin/bash /home/ibi/Documents/Git/Bash/testscript.sh #14:55 29 June Monday
crontab -l #list my table
crontab -e -u {another_user} #crontab of another user
ls /etc | grep cron.deny #if there is no cron.deny or cron.allow, only admins are allowed to run cron



''' anacron '''
cat /etc/anacrontab #runs missed tasks