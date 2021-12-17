#!/bin/bash

echo "Install packages"
echo "Install editors"
sudo apt install -y vim

echo "Install network tools"
sudo apt install -y net-tools

echo "Install system monitoring tools"
sudo apt install -y htop

echo "Install web servers"
sudo apt install -y nginx apache2

echo "Install misc"
sudo apt install -y jq yq

echo "Install docker"
install_docker() {
    echo "Installing Docker"
    sudo apt -y install curl
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo apt-add-repository  "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    sudo apt update -y
    sudo apt install -y docker-ce
    sudo usermod -aG docker ${USER}
}
docker &&  echo "No need to install Docker" || install_docker


echo "Bash profile"
echo -e "\nalias ll='ls -hal'" >> ~/.bashrc
echo "alias gacp='git add .; git commit -m \"Aliased commit\"; git push'" >> ~/.bashrc
source ~/.bashrc


echo "Sudo password prompt & SSH"
echo "SSH Key (For GitHub)"
ssh-keygen -t ed25519 -C "ibili73@gmail.com"
echo """
*** Run the following commands to run sudo without password prompt ***

$ sudo visudo
ibi ALL=(ALL) NOPASSWD: ALL

***
"""
