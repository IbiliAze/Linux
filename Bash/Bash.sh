#!/bin/bash


''' Configuring Bash '''
cat /etc/profile #standard config for all users
cat /etc/bashrc #default bash config for all users
vim ~/.profile #config when I login
cat ~/.bash_profile #program bash runs
cat ~/.bashrc #bash config for the user
echo $PATH #where to look for a command
source ~/.bash_profile #refresh for this session
EXAMPLE="hello" #local env
export EXAMPLE 
set -o allexport #make all env's global
alias lll='ls -hall'
unalias lll
sudo vim ~/.bashrc 
    > function sysinfo #custom command
        {
          uname -a 
          uptime
          whoami 
        }
source ~/.bashrc #make the custom command global for the user



''' Bash Scripting '''
echo -e #wait for user input
seq 1 10 #print 1 to 10

echo -e "Username"
read username
test -d /home/$username && echo "Home folder already exists for $username" || echo "Home folder does not exist for $username"
# && if it passes, || if it fails

filenum=10
filenum=$(($filenum - 1)) 


-d {file} #if file exists and is a directory
-e {file} #if file exists
-f {file} #if file exists and is a file
-z {file} #if file exists and is empty
-n {file} #if file exists and is not empty
-r {file} #if file exists and is readable
-s {file} #if file exists and is not empty
-w {file} #if file exists and is writable
-x {file} #if file exists and is executable
-O {file} #if file exists and is owned by the current user
-G {file} #if file exists and default group is the same as current user
{file1}  -nt  {file2} #newer than
{file1}  -ot  {file2} #older than

val++ 	#post-increment
val-- 	#post-decrement
++val 	#pre-increment
--val 	#pre-decrement
!	#logical negation
~	#bitwise negation
**	#exponent
<.<	#left bitwise shift
>> 	#right bitwise shift
&	#bitwise boolean AND
|	#bitwise boolean OR
&&	#logical AND
||	#logical OR

#.	#Pattern match any SINGLE character except newline characters
*	#Match preceding character ZERO or more times
?	#Match preceding character ZERO or ONE times
+	#Match preceding character ONE or more times
[]	#Character classes
^	#Starts with
$	#Ends with
{}	#Limits
\	#Escape
|	#OR
()	#Grouping

