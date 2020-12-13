#!/bin/bash



[ Partitioning ]

lsblk #list disks and uuids
sudo fdisk -l /dev/sdb #info about the disk (MBR)

sudo fdisk /dev/sdb #fdisk editor (MBR)
    > n #new partition
    >> p #primary
    >> 1 #partition number
    >> 2048 [default] #start of sector number
    >> +500G # end of sector number, size of disk
    > p #print details
    > t #change partition system id
    >> 2 # partition number
    >> L #list codes
    >> 82 #linux swap
    > w #save

sudo gdisk /dev/sdc #(GPT)
    > ? #help
    > n #new partition
    >> 1 #partition number
    >> +500G
    >> L
    >> 8200 #swap
    > w

sudo parted /dev/sdb #partition editor
    > help



[ swap Partition ]

sudo fdisk /dev/sdb
    > n
    >> 1
    >> 2048
    >> 500M
    > t
    >> 82
    >> p
    > w
lsblk

# OR

sudo gdisk /dev/sdb
    > n
    >> 1
    >> 2048
    >> +500M
    >> L
    >> 8200
    > w
    >> Y
lsblk
