#!/bin/bash


whoami
su {user} #change the user context (becoming a user)
su - {user} #into user's home directory (login session)
sudo cat /etc/sudoers #see who can run the sudo command
which ip #location of the ip command
sudo visudo /etc/sudoers #specifically for editing the sudoers file (error correction)
    > ibi    ALL=(ALL) NOPASSWD:ALL #from any workstation, any command, autheticate for all commands) 
    > {user} ALL=/usr/sbin/ip, /usr/sbin/ifconfig  #user only has 2 runnable commands 'sudo ip' and 'sudo ifconfig'
sudoedit /etc/hosts #edit a file with your default text editor
alias #see aliasses