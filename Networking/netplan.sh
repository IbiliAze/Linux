#!/bin/bash



sudo vim /etc/netplan/99_config.yaml #edit interface config on ubuntu
sudo cd /etc/netplan
sudo netplan apply #apply changes on ubuntu
