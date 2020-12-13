#!/bin/bash


at 10 PM Fri
    >./script.sh
    >ls
    \ CTRL+D
atq #job queue
atrm 2 #remove job number 2
ll /etc | grep at #if there is no at.deny or at.allow, only admins are allowed to run at
sudo /etc/at.deny #who's not allowed to use at