#!/bin/bash




systemctl status sshd #see the status of ssh server/daemon and the listening port

vim /etc/ssh/sshd_config #sshd server config



[ Basic SSHD Custom Config ] #for SSH, SCP, SFTP

{Protocol}
echo '''Protocol 2''' >> /etc/ssh/sshd_config #ssh version 2


{Port}
echo '''Port 3000''' >> /etc/ssh/sshd_config #change default listening port


{Root}
echo '''PermitRootLogin no''' >> /etc/ssh/sshd_config #root can't login over SSH
 

{Users}
echo '''DenyUsers baduser1 baduser2''' >> /etc/ssh/sshd_config #blacklist

echo '''AllowUsers gooduser1 gooduser2''' >> /etc/ssh/sshd_config #whitelist


{Authentication}
echo '''MaxAuthTries 6''' >> /etc/ssh/sshd_config


{Passwords}
echo '''PermitEmptyPasswords yes''' >> /etc/ssh/sshd_config #not safe

echo '''PasswordAuthentication yes''' >> /etc/ssh/sshd_config #allow password authentication


{Banner}
echo '''Banner /etc/ssh/banner''' >> /etc/ssh/sshd_config

echo '''PrintMotd yes''' >> /etc/ssh/sshd_config #message of the day file at /etc/motd


{Tunneling}
(X)
echo '''X11Forwarding yes''' >> /etc/ssh/sshd_config #GUI component commands can be SSH tunneled

ssh -Y user1@10.253.104.62 #-Y=X tunneling



[ SSH Client ] 

ssh user1@10.253.104.62 <command> #run a command upon logging in 

ssh -Y user1@10.253.104.62 #-Y=X tunneling



[ SCP ]

scp /home/user/myfile.txt user1@10.253.104.62:~/myrenamedfile.txt

scp -r /home/user/ user1@10.253.104.62:~/myrenamedfile.txt #-r=recursive folders
 
scp -r -q /home/user/ user1@10.253.104.62:~/myrenamedfile.txt #-q=quiet
 
scp -v /home/user/ user1@10.253.104.62:~/myrenamedfile.txt #-v=verbose

scp -i ~/.ssh/mykey.pem /home/user/myfile.txt user1@10.253.104.62:~/myrenamedfile.txt
 
scp user1@10.253.104.62:~/myrenamedfile.txt /home/user/myfile.txt #copy from a remote location



[ SFTP ]

sftp user1@10.253.104.62
    >ls -al
    >get fileinthisdirectory.txt
    >quit



[ Version 1 ]

echo '''Protocol 1''' >> /etc/ssh/sshd_config

ssh -1 ibi@10.1.1.32 #explicitly try connecting via sshv1



[ Keys ]

sudo rm -f *_key* #-f=force, remove every key

sudo ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key #-t=type, -f=location

sudo ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key #-t=type, -f=location

sudo ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key #-t=type, -f=location

ssh-keyscan 10.1.1.32 >> ~/.ssh/known_hosts #>> add, get the public key of 10.1.1.32

ssh-keygen -lf /etc/ssh/ssh_host_ecdsa_key_pub #-lf=generating a finger-print of the public key

ssh-keygen -lf /etc/ssh/ssh_host_ecdsa_key_pub -E sha256

ssh-keygen -lf /etc/ssh/ssh_host_ecdsa_key_pub -E sha512

ssh-keygen -lf /etc/ssh/ssh_host_ecdsa_key_pub -E md5

cat ~/.ssh/known_hosts #verify the public key has been added to the known hosts

cp ~/.ssh/known_hosts /etc/skel/.ssh #add the known_hosts file to every users home directory


{MFA}
ssh-keygen #use passphrase


{SSH Agent}
ssh-agent /bin/bash #attaching the agent to a new shell, will ask the passphrase once
ssh-add


{Copy Public Key}
ssh-copy-id user1@10.253.104.62 #will copy /home/<user>/.ssh/id_rsa.pub from host to remote

ssh-copy-id -i /home/ibi/.ssh/ansible.pub ibi@192.168.0.136

cat ~/.ssh/id_rsa.pub | ssh user1@10.253.104.62 'cat >> .ssh/authorized_keys' #manual copy





