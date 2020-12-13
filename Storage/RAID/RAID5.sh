#!/bin/bash


#System RAID
sudo su
fdisk /dev/xvdb #3 partitions
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
    > set 5 raid on #skip 4 as it's the extended partition
    > set 6 raid on
    > set 7 raid on
    > print
    > quit
fdisk -l /dev/xvdb #view the configs
fdisk -l /dev/xvdc
yum install -y mdadm

#Software RAID
mdadm -C /dev/md0 -l raid5 -n 3 /dev/xvdb1 /dev/xvdb2 /dev/xvdb3 -x 3 /dev/xvdc1 /dev/xvdc2 /dev/xvdc3 #-C=create, -n=number of active devices, -x=extra
ls /dev/md*
mdadm -D /dev/md0 #-D=detail
cat /proc/mdstat #RAID info
mdadm -D -s -v #-s=scan, -v=verbose, can be used for a config file
mdadm -D -s -v >> /etc/mdadm.conf #persistent config
mkdir /mnt/data
mkfs.ext4 dev/md0
mount -t ext4 /dev/md0 /mnt/data/
mkdir /mnt/data/backup
blkid #copy the UUID of the block
    > UUID=003a9fc3-df73-445a-822d-627473acc0ef     /mnt/data   ext4   defaults 0 0
mount -a #mount reading the /etc/fstab

cp /etc/* -rf /mnt/data/backup/ #testing




