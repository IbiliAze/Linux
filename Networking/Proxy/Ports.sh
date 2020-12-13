#!/bin/bash


[ Set up a Listener ]

sudo apt install -y ncat #for listening on a port
nc -l 5000 #run on remote machine to listen on port 8080
telnet 54.163.176.159 5000 #run on local machine



[ Listening Ports ]

ss -lntp 
