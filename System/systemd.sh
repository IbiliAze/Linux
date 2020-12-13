#!/bin/bash


ps aux #running processes, a all user initiated, u username, x show apps running without a shell
ps aux | head -n 2 #if systemd or sysvinit

ls -l /sbin/init
cd /lib/systemd/system #system unit files, runs in background
cd /etc/systemd/system #where we can edit files (overwrites)

sudo systemctl start httpd.service #start httpd on-demand
sudo systemctl enable httpd.service #turns on httpd automaticaaly even after a reboot

sudo systemctl isolate multi-user.target #no x
sudo systemctl list-units 
sudo systemctl list-units -t services

sudo systemctl mask httpd.service #prevent httpd from starting and enabling
sudo systemctl unmask httpd.service
sudo systemctl is-active httpd.service #one word status check
sudo systemctl is-enabled httpd.service
sudo systemctl get-default #get current .target
sudo systemctl set-default multi-user.target
sudo systemctl list-dependencies graphical.target
sudo systemctl isolate rescure #rescue mode

sudo systemctl -H 192.168.0.31 status docker #run on remote server



[ Other useful Commands ]

systemd-analyze #how long it took to boot

localectl #locale and keyboard mapping
hostnamectl #about the os
hostnamectl set-location "Rack1, shelf 34"

systemd-resolve #host -> IP and Vice-Versa

systemd-inhibit {some.command} #prevents sleeping & shutting down while a command is running

systemctl list-units -t target #active target unitfiles
systemctl list-units -t service

systemctl reload httpd.service #to read the updated config file



[ Unitfiles ]

sudo ls /usr/lib/systemd/system #unit files, DO NOT ALTER HERE
sudo ls /etc/systemd/system #unit files, alter here, Takes Precedence over /usr
sudo ls /run/systemd/system #runtime unit files
sudo systemctl list-unit-files #all unitfiles
sudo systemctl cat docker.service

{ Editing Unitfiles }
sudo cp /usr/lib64/systemd/system/unit.unit /etc/systemd/unit.unit #first way
sudo mkdir /etc/systemd/system/docker.service.d/ #second way, step 1
sudo vim /etc/systemd/system/docker.service.d/docker.conf #second way, step 2
sudo systemctl edit <unit> #second way, the safer better way
sudo systemctl edit --full <unit> #comletely overwrite the original unitfile
sudo systemd-delta #view modified unit files
sudo systemctl daemon-reload #must run after modifying a unitfile

{ Basic Unitfile }
[Unit]
Description=Multi-User System
Documentation=man:systemd.special(7) #can specify URL, file, multiple files separated by a space
Requires=basic.target #units that will be activated when this unit is activated
>OR
Wants=basic.target #if basic.target fails to activate it will not stop the unit from activating
Conflicts=rescue.target #what can't be running when this unit is active
After=basic2.target #basic2.target has to be activated first

{ Target Unitfiles } #syncs up other units when the computer boots or changes states
multi-user.target #CLI
graphical.target
rescue.target #rescue shell
basic.target #used during boot process
sysinit.target #system initialisation

systemctl list-unit-files -t target #all target unitfiles
systemctl list-units -t target #active target unitfiles
systemctl get-default
systemctl set-default multi-user.target
systemctl isolate multi-user.target #change to
systemctl rescue
systemctl default
systemctl poweroff

{ Service Unitfiles } #gets things done
[Service]
Type=
ExecStart= #command with arguments that will start when this service is activated
[Install] #only read during systemctl enable/disable
WantedBy= #what other units will want this unit if it were enabled (symlink to target unit's .wants directory)

{ Service Unitfile "Types" }
Type=simple #the process started by ExecStart
Type=forking #the process started by ExecStart then forks-off to children processes
Type=oneshot
Type=dbus
Type=notify
Type=idle

{ Timer Unitfiles } #must have corresponding .service unitfile













