#!/bin/bash


[ Installation ]

sudo apparmor_status #see if it's enabled

sudo apt list apparmor*

sudo apt install -y apparmor

sudo apt install -y apparmor-profiles

sudo apt install -y apparmor-utils



[ Config ]

sudo ls /etc/apparmor.d/ #where config files are stored, the names correspond with the relative name of the sbin file

aa-unconfined #see unconfined apps

aa-genprof apache2 #generate a profile for apache2

sudo aa-enforce /etc/apparmor.d/usr.sbin.apache2


