#!/bin/bash



yum install -y dovecot

systemctl start dovecot

doveconf #running config for dovecot

doveconf -n #

telnet localhost 110 #test listenning connection
telnet localhost 143 #IMAP service availability

openssl s_client -connect localhost:995 #POP3 SSL check
                                   :pop3s
openssl s_client -connect localhost:993 #IMAP SSL check
                                   :imaps

echo '''mail_location = maildir:~/Maildir''' >> /etc/dovecot/conf.d/10-mail.conf #default mail directory



[ SSL ]

ll /etc/pki/dovecot/certs/
ll /etc/pki/dovecot/private/

openssl s_client -connect localhost:995 #POP3 SSL check

openssl s_client -connect localhost:993 #IMAP SSL check



[ Outlook ]

echo '''pop3_uidl_format = %08Xu%08Xv''' >> /etc/dovecot/conf.d/20-pop3.conf
echo '''pop3_client_workarounds = outlook-no-nuls oe-ns-eoh''' >> /etc/dovecot/conf.d/20-pop3.conf



