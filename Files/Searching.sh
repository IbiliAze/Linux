#!/bin/bash




tail -f /var/log/messages #-f following a file changes live
tail -f /var/log/secure & #& run in background (for RH)
journalctl -t su -f #safer (for RH)
find . -name test.txt
find . -name "*.txt" #find any files with the extension .txt
find / -name test.txt 2> /dev/null # as we are searching the entire hard drive, we want to bin the permission denied STDERR messages
find ~ -perm +rwx #find files with read, write, execute permissions
find / -size 5000M 2> /dev/null #find files with size larger than 5GiB
find ~ -user ibi #find files owned by ibi
find ~ -uid 1002 #find files owned by a user with the id 1002
find ~ -name test.txt -maxdepth 1 #don't search above 1 subfolder
locate test.txt #file has to be in the database
which {command} #location of the command
whereis {command} #location of the command, copy of the command and the help docs
type {command} #how the command is stored
