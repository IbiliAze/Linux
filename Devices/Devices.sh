#!/bin/bash




[ Devices ]

/dev/random #random number generator
/dev/urandom #with software

cd /etc/udev/rules.d #overwrite rules for renaming devices

sudo udevadm control --reload-rules #reload rename-overwite rules
sudo udevadm trigger #apply & see new devices without rebooting



[ ls ] #alias to /sys & /dev

lsblk

lspci #all the pci connected hardware

lsusb

lscpu

lsdev



[ dmesg ]

dmesg | less #device logs

dmesg | less | grep error

dmesg --follow #live logs

sudo udevadm monitor #live logs into the kernel

dmidecode #system info



