#!/bin/bash


chmod u+rwx,g+rwx,o+rwx test.txt 
chmod u=rw,g+rwx,o+rwx test.txt #= means make sure its just that
chmod -R a+X dir1 #-R recursive, a all, X execute permissions for directories only
less ~/.bashrc #default file permissions (umask)
less ~/.bash_profile #2n default file permissions (umask)
less /etc/profile #last place for file permissions (umask)
sudo chgrp bob file1 #change the group owner



''' Sticky Bit '''
chmod o+t test #everything in the test folder, the only file a user can delete is the file they created, not any other files
chmod 1000 test #d--------T. 2 ibi ibi  6 Jul  8 11:31 test


''' SGID '''
chmod g+s adir  #DIRECTORY, newly created objects inside the directory will belong to the directory group
                #EXECUTABLE, has permission to change its group ID, while executing to that group that owns the exe
chmod u+s adir
chmod g+s adir
chmod 2777 adir


''' SUID ''' 
chmod u+s  #program runs as the owner, rather than the caller


''' Special Permissions '''
d    rwx     rwx     rwx
     421     421     421  =  777
                                   
                                   chmod 3777 adir
     rwx͟     rws͟     rwt͟   
               2       1  =  3   

chmod 7000 test #d--S--S--T. 2 ibi ibi  6 Jul  8 11:31 test
chmod 7777 test #drwsrwsrwt. 2 ibi ibi  6 Jul  8 11:31 test
find / -type d -perm /2000 -ls #d directory, -ls verbose


''' umask '''
0666 #default permissions for files
0777 #default permissions for directories
0022 #root file mask 
0022 #root dir mask
0002 #user file mask
0002 #user dir mask
Permissions = Default - umask
