#!/bin/bash


cd /etc/apt #source repos
apt list httpd #search
apt search httpd #full search
sudo vim /etc/apt/sources.list #add a repo
sudo apt-add-repository  "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" #same as above
sudo apt-key addkeyname.asc #add a digital signature
sudo apt update; sudo apt upgrade #update packages
sudo apt dist-upgrade #kernel/os update
