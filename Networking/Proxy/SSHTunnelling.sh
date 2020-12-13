#!/bin/bash



[ Local SSH Tunnelling ]

#
#  :8080   <==   <--   <==  :80          Local Server sees the
#   ____        ____         ____        contents of Remote Server
#  |    |      |    |       |    |       by cURLing localhost:8080
#  |    |  <== |.154|  <==  |.188|       
#  |____|      |____|       |____|
#   local       int.        remote
#

sudo ssh -i ~/.ssh/ubuntuKP.pem -L 8080:54.173.31.188:80 ec2-user@54.226.142.154 #1st IP=internal, 2nd IP=external
ss -lntp
curl localhost:8080

# Using 2 servers
sudo ssh -i ~/.ssh/ubuntuKP.pem -L 8080:54.173.31.188:80 -L 9090:54.226.142.154:80 ec2-user@54.226.142.154
ss -lntp
curl localhost:8080
curl localhost:9090



[ Remote SSH Tunnelling ]

#
#  :5000   ==> :8080   ==>  :8080        Remote Server sees the
#   ____        ____         ____        contents of Local Server
#  |    |      |    |       |    |       by cURLing the intermediate
#  |    |  ==> |.154|  ==>  |.188|       server:8080
#  |____|      |____|       |____|
#   local       int.        remote
#

#Local Server
docker run -d -p 5000:80 --name localnginx nginx #local web server to be available at an internal network

#Intermediate Server @sudo ssh -i .ssh/ubuntuKP.pem ec2-user@54.226.142.154
sudo vim /etc/ssh/sshd_config #GatewayPorts yes
sudo systemctl restart sshd
exit

#Local Server again
sudo ssh -i ~/.ssh/ubuntuKP.pem -R 8080:localhost:5000 ec2-user@54.226.142.154 #IP=intermediate server, start the new SSH tunnel

#Remote Server @sudo ssh -i .ssh/ubuntuKP.pem ec2-user@54.173.31.188
curl 54.226.142.154:8080 #IP=intermediate server



[ Dynamic SSH Tunnelling ]

sudo ssh -i ~/.ssh/ubuntuKP.pem -D 8080 ec2-user@54.226.142.154 #intermediate server
