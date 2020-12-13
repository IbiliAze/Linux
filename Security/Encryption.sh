#!/bin/bash

blkid #view all drives
sudo umount /dev/sdb1 #unmount, /dev/sdb1 is a drive
sudo shred -v --iterations=1 /dev/sdb1 #-v verbose, --iterations=1 how many times to overwrite the disk to make sure it's fully empty
sudo cryptsetup --verbose --verify-passphrase luksFormat /dev/sdb1 #format the disk as an encrypted device
sudo cryptsetup luksOpen /dev/sdb1 storage1 #storage1 virtual storage name, unlock and format the drive
sudo mkfs.xfs /dev/mapper/storage1 #mount the disk and format it
sudo mount /dev/mapper/storage1 /mnt/storage1