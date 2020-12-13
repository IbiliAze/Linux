#!/bin/bash



cd /etc/yum.repos.d #yum repos
yum list apache*
yum search apache
yum info httpd
sudo vim etc/yum.repos.d/repo.repo #add a repo
sudo rpm --import key.asc #import a digital sugnature
sudo yum erase webmin #remove an app and the cache, agressive
yum history
yum history list {number}
yum history undo {number}
yum history info {number}
yum history rollback
yum groups list
yum groups install /{packagegroup}
tail /var/log/yum.log