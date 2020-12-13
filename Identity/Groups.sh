#!/bin/bash



sudo groupadd {group} #add a group
less /etc/group #list all groups and its respective users
groups #see the groups you're in
groups {user} #see what groups a user is in
sudo groupmod -n {newname} {oldname} #change the group name
sudo gpasswd -a {user} {group} #add a user to a group
sudo gpasswd -d {user} {group} #delete a user from a group
sudo gpasswd -A {user} {group} #make user the admin of the group
newgrp {othergroup} #temporarily change your group context
sudo chown {admin}:{group} file.txt #change the files owner and group
sudo chown -R {admin} ~/* #take owndership of your home directory and whole directory tree within the home directory
getent passwd ibi #get entity; searching
getent group ibi #searching
cat /etc/passwd | grep ibi #searching with grep