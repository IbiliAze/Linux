#!/bin/bash



[ iostat ]

yum provides */sysstat
yum install -y sysstat

iostat -c #-c=CPU

iostat -c -h #-h=human readable

iostat -c 2 5 #2=every 2 seconds, 5=display 5 times (think -f)

iostat -d #only disk info



[ iotop ]

yum install -y iotop

iotop #top command for disk



[ sar ]

yum provides */sar
yum install -y sysstat
systemctl start sysstat
systemctl enable sysstat

sar #CPU info

sar -d #device/disk info

ll /var/log/sa/ #creates a file every 10 minutes



[ lsof ]

yum install -y lsof

lsof #running files

lsof | head

lsof | wc -l #word count by lines => number of files open

lsof -u user1 #-u=user
lsof -u user1 | wc -l #number of files running by the user

ls -al /dev/ | grep "136, *" #finding the device


{Troubleshooting high resource usage}
top #find the pid of the process
lsof | grep <pid> #find the files related to the process
ls -al /dev/ | grep "0, *" #find the device





