#!/bin/bash




[ APT ]

apt list apache2 #search

apt search apache2 #full search

sudo apt update; sudo apt upgrade #update packages

sudo apt download apache2 #downloads but doesn't install

sudo apt dist-upgrade #kernel/os update


{Removing}
sudo apt remove apache2

sudo apt purge apache2 #remove the config files as well


{Cache}
sudo apt-cache search apache2

sudo apt-cache show apache2 #info about the package

sudo apt-cache showpkg #more info


{Repos}
/etc/apt #source repos

sudo vim /etc/apt/sources.list #add a repo

sudo apt-add-repository  "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" #same as above 

sudo apt-key addkeyname.asc #add a digital signature



[ DPKG ]

sudo apt download htop
sudo dpkg --info htop_2.2.0-2build1_amd64.deb #info about the package

sudo dpkg --status apache2 #information about installed packages

sudo dpkg -l apache2 #-l=list information, same as above

sudo dpkg -i htop_2.2.0-2build1_amd64.deb

sudo dpkg -L htop #list out files that were installed with a package

sudo dpkg -S vim #-S=search

sudo dpkg-reconfigure <package> #re-run the configuration utility of the package


{Removing}
sudo dpkg -r htop #-r=remove

sudo dpkg -P htop #-P=purge, remove the config files as well



