#!/bin/bash



[ Target / Server ]

yum update -y; amazon-linux-extras install epel; yum install -y epel-release; yum install -y scsi-target-utils

echo '''<target iqn.<year>-<month number>.<domain>.<host>:<your internal device name>
    backing-store /dev/sda1
    initiator-address <IP address of the connecting device>
</target>''' >> /etc/tgt/target.conf
/etc/init.d/tgtd start
systemctl start tgtd
tgt-admin --show



[ Initiator / Client ]

yum update -y; amazon-linux-extras install epel; yum install -y epel-release; yum install -y iscsi-initiator-utils

iscsiadm -m discovery -t sendtargets -p 172.31.31.171 #discover the remote Target / Server
systemctl restart iscsi; systemctl status iscsi
lsblk #should see the device 'sda'
fdisk /dev/sda
mkfs.ext4 /dev/sda1
mount /dev/sda1 /mnt/data
# OR (recommended)
blkid #copy the block ID
echo '''UUID=004355345v345348435n8      /mnt/data       ext4    _netdev    0   0''' >> /etc/fstab #_netdev=wait for the network to be available
mount -a

df -h



