#!/bin/bash


top #top resource consumers by CPU
    > M #sort by memory
    > P #CPU
    > u ibi #username
    > k 423 #kill PID 423
systemd-analyze blame #which process took the longest when booting
lsof #list open files
lsof | grep "test.txt" #show the user and the application using the file
jobs #jobs running in background
%1 #go back to the job with the id 1
fg 1 #foreground, same as above
bg 1 #background, send the app with an id 1 to background and NOT pause
nice 11 -n 11 vim ./test.txt # -20 most resources (kernel), 20 least resources (vim)
renice -n 12 3213 # 3213 is PID, change th priority of a running app
pgrep vim #get PID of vim
kill 5082
killall firefox #any process with firefox
dmesg #kernel messages
dmesg -T #with date
