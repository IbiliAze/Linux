#!/bin/bash


#System RAID
sudo su
fdisk /dev/xvd #3 partitions
    > n
    >> p
    >> 1
    >> 2048
    >> +200M
    >>
    > n
    >> p
    >> 2
    >> 2048
    >> +200M
    >>
    > n
    >> p
    >> 3
    >> 2048
    >> +200M
    > p #list partitions
    > l #list partition types
    > t #change partition type
    >> 1
    >> fd
    > t
    >> 2
    >> fd
    > t
    >> 3
    >> fd
    > p
    > w
lsblk
# OR
parted /dev/xvdc #could use fdisk or gdisk
    > mklabel msdos
    > mkpart primary 1 200
    > mkpart primary 201 400
    > mkpart primary 401 600
    > mkpart extended 601 2100 #utilising the 4th (last) MBR table as an extended logical
    > mkpart logical 602 800
    > mkpart logical 801 1000
    > mkpart logical 1001 1200
    > print
    > set 1 raid on
    > set 2 raid on
    > set 3 raid on
    > set 5 raid on #skip 4 as it's the logical partition
    > set 6 raid on
    > set 7 raid on
    > print
    > quit
fdisk -l /dev/xvdb #view the configs
fdisk -l /dev/xvdc
yum install -y mdadm

