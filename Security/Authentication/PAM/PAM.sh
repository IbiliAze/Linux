#!/bin/bash



[ PAM ]

{pam_unix}
echo '''password    sufficient  pam_unix.so try_first_pass use_authtok nullok sha512 shadow remember=3''' >> /etc/pam.d/system-auth 
#remember=cannot change the password to the previous password


{pam_cracklib}
echo '''password    requsite    pam_cracklib.so try_first_pass retry=3 minline=10 type=''' >> /etc/pam.d/system-auth
#retry=lock-out after 3 password attempt failures
#minline=minimum characters


{pam_limits}
echo '''@user1          hard    maxlogins       1''' >>/etc/security/limits.conf
#user1 can only log in once


{pam_listfile}
echo '''auth       required     pam_listfile.so item=user sense=deny file=/etc/vsftpd/ftpusers onerr=succeed''' >>/etc/security/vsftpd
#deny access for any users in '/etc/vsftpd/ftpusers', onerr=succeed=carry on running the modules below if errored


{nsswitch}
echo '''passwd:      sss files systemd''' >> /etc/nsswitch.conf 
#order of databases for authentication 



[ SSSD ]

yum install -y openldap-clients sssd sssd-client 










