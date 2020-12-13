#!/bin/bash



[ cryptsetup ]

yum install -y cryptsetup

cryptsetup luksFormat /dev/sda1 #encrypt a drive
cryptsetup luksOpen /dev/sda1 encryptedVolume #encryptedVolume=name, mount & open volume for writing
mkfs.xfs /dev/mapper/encryptedVolume
mount /dev/mapper/encryptedVolume /mnt/data/

umount /mnt/data/
cryptsetup luksClose encryptedVolume #close the device



[ Key Files ]

dd if=/dev/urandom of=./keyfile bs=4096 count=1 #generate a 4K random file using /dev/urandom as input
cryptsetup luksAddKey /dev/xvdb1 ./keyfile #locking the device with the keyfile
echo 'mysecretdevice    /dev/xvdb1      /home/ec2-user/keyfile    luks' >> /etc/crypttab
echo '/dev/xvdb1    /mnt/data   xfs     defaults    0   0' >> /etc/fstab
reboot


