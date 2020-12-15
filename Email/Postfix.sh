#!/bin/bash



yum install -y postfix
systemctl start postfix

postconf -n #see the custom running commands in /etc/postfix/main.cf

postconf #all the commands

telnet localhost 25 #connection listening check

cat /var/log/maillog #log file

tail -f /var/log/maillog

ll /var/spool/mail/ #users for email sending tests



[ mailx ] 

yum install -y mailx #sending test emails

mailx -s "This is a Subject" user1 #-s=subject
    >this is my text
    >. #EOF, will end the text body and send the email
su user1
mail #run this as user1, will display the received email
    ><enter> #will view the email body
    >d #delete the email
    >q #quit



[ Aliases ]

echo '''doesntExist:    user2''' >> /etc/aliases #any email to user doesntExist will be forwarded to user2
systemctl stop postfix
newaliases #covert the /etc/aliases file to binary
systemctl start postfix
mailx -s 'hi' doesntExist
    >alias text
    >.
su user2
mail #should receive the email
    ><enter>
    >d
    >q


{Virtual} #redirect email to virtual destinations
echo '''thisAccount@doesntexist.com             superman
thisAccountAlso@doesntexistToo.com      spiderman''' >> /etc/postfix/virtual
postmap /etc/postfix/virtual #covert the /etc/postfix/virtual file to binary
echo '''# virtual_alias_maps = unix:hash:/etc/postfix/virtual''' >> /etc/postfix/main.cf
systemctl restart postfix
cat /var/log/maillog



[ Destination ] 





[ Domain ]

echo '''myhostname = localhost.localdomain''' >> /etc/postfix/main.cf

echo '''mydomain = localdomain''' >> /etc/postfix/main.cf



[ Relay ]





[ Security ]

echo '''disable_vrfy_command = no''' >> /etc/postfix/main.cf



[ Networking ]



