#!/bin/bash

echo step 1
sudo apt install -y nginx

echo step 2
sudo minikube ip

echo step 3
kubectl get services #get NodePort port

echo step 4
sudo cp ./default /etc/nginx/sites-enabled/default #appended as such over line 40-50: https://ip:port

echo step 5
sudo systemctl restart nginx

echo step 6
sudo systemctl status nginx
