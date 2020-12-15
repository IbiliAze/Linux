#!/bin/bash



[ YUM ]

{Repos}
cd /etc/yum.repos.d #yum repos

sudo vim etc/yum.repos.d/repo.repo #add a repo

sudo rpm --import key.asc #import a digital sugnature


{Informational}
yum list apache*

yum search apache

yum info httpd

yum list installed

yum provides */httpd #which package provides the httpd package


{Cache}
yum clean all #clean YUM's cache


{Removing}
sudo yum remove httpd

sudo yum erase webmin #remove an app and the cache, agressive

sudo yum autoremove httpd #remove the dependencies as well


{History}
yum history

yum history list {number}

yum history undo {number}

yum history info {number}

yum history rollback


{Group Install}
yum groups list

yum groups install /{packagegroup}



[ RPM ]

rpm -Va #-Va=verify all installed packaged

rpm2cpio <rpm packgae>.rpm | cpio -idmv #converts .rpm file into a cpio archive file


{Informational}
rpm -qpi <rpm packgae>.rpm #-q=query, -p=package, -i=info, same as yum info

rpm -qpl <rpm packgae>.rpm #-l=list files in package

rpm -qa #list all installed packages


{Installing}
rpm -i <rpm packgae>.rpm #-i=install

rpm -ivh <rpm packgae>.rpm #-v=verbose, -h=hash-marks

rpm -U <rpm packgae>.rpm #-U=upgrade


{Removing}

rpm -e <rpm packgae> #-e=erase


