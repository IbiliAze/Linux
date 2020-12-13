#!/bin/bash


systemctl status sshd #see the status of ssh server/daemon and the listening port
sudo cat /etc/ssh/sshd_config #see sshd server config
    >Protocol 2 #ssh version 2
ssh -1 ibi@10.1.1.32 #explicitly try connecting via sshv1
sudo systemctl restart sshd #restart sshd so that it can read the config file that was just changed
ls /dev
    >urandom #used by the device to make a random key; unreliable
sudo rm -f *_key* #-f force, remove every key
sudo systemctl sshd stop #stop sshd server
sudo ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key #-t type, -f location
sudo ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key #-t type, -f location
sudo ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key #-t type, -f location
sudo systemctl start sshd
cd ~/.ssh
ssh-keyscan 10.1.1.32 >> ~/.ssh/known_hosts #>> add, get the public key of 10.1.1.32
ssh-keygen -lf /etc/ssh/ssh_host_ecdsa_key_pub #-lf generating a finger-print of the public key
ssh-keygen -lf /etc/ssh/ssh_host_ecdsa_key_pub -E sha256
ssh-keygen -lf /etc/ssh/ssh_host_ecdsa_key_pub -E sha512
ssh-keygen -lf /etc/ssh/ssh_host_ecdsa_key_pub -E md5
cat ~/.ssh/known_hosts #verify the public key has been added to the known hosts
cp ~/.ssh/known_hosts /etc/skel/.ssh #add the known_hosts file to every users home directory

ssh-copy-id -i /home/ibi/.ssh/ansible.pub ibi@192.168.0.136
