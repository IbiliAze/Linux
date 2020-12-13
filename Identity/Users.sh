#!/bin/bash


sudo useradd {user}
sudo useradd -c "Username 2" user2 -e 2020/12/31 -s /bin/dash -d /home/userr2 #-c command, often used for the users full name, -e expiration date, -s default shell, -d default home folder
sudo useradd -D #see the defaults when adding a user
sudo id {user} #get the id of a user
sudo userdell {user} #delete a user
sudo userdell {user} -r #remove the home directory
sudo usermod ___ #modify the user
sudo usermod -l new_name old_name #change the user login name
sudo usermod -L ibi #lock a user
sudo usermod -U ibi #unlock a user
sudo usermod -s /sbin/nologin bob #no shell access
sudo passwd {user} #set a user password
sudo chage {user} -l #see the password policies of a user
sudo less /etc/login.defs #2nd place for additional defaults we get 
sudo less /etc/default/useradd #3rd place for defaults
less /etc/passwd #users
sudo /etc/shadow #passwords
less /etc/group #groups
chsh #change user's shell