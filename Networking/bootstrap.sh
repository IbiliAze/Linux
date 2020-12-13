#!/bin/bash

sudo yum update -y
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
sudo echo $(ip a) > /var/www/html/index.html
sudo echo public >> /var/www/html/index.html
