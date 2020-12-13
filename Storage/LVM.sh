#!/bin/bash



[ Informational ]

sudo apt list lvm*

sudo apt install lvm2

ls /usr/sbin/v*

ls /usr/sbin/l*

ls /usr/sbin/p*

pvdisplay #physical volume information

vgdisplay

lvdisplay

pvs #summary

lvs

vgs

pvscan #scall all supported LVM devices

vgscan

lvscan



[ Logical Volumes ]


#  pv     pv     pv           vg           lv      lv
#  __     __     __         ______        ____     __
# |  | + |  | + |  |  -->  |      |  =>  |    | + |  |
# |__| + |__| + |__|  -->  |______|  =>  |____| + |__|
#  1G     1G     1G           3G           2G      1G
#


sudo su

{Physcial Volumes}
pvcreate /dev/sdb1/ /dev/sdc1 #create physical volumes from physical disks

pvdisplay #show physical volumes

pvdisplay /dev/sdc1

pvremove /dev/sdb1 /dev/sdc1 /dev/sdd1


{Volume Group}
vgcreate vg1 /dev/sdb1 /dev/sdc1

vgcreate -s 8MB vg1 /dev/sdb1 /dev/sdc1 #-s=extent size

vgdisplay

vgdisplay vg1

vgdisplay -v vg1 #-v=verbose

vgextend vg1 /dev/sdc2 #add another physical volume, this command will make the volume a physical volume automatically on LVM2

vgremove vg1


{Logical Volumes}
lvcreate -L 1500G vg1 -n lv1 #-L size, -n name

lvcreate -L 1500G vg1 -n lv1 -i 4 #-i=use all x devices

lvdisplay

lvdisplay -v #-v=verbose

lvdisplay -vv #-vv=more verbose

lvdisplay -vvv

ls -al /dev/vg1/lv1 #logical volume name and the mapped name

ls -al /dev/mapper/vg1-lv1 #same as above

(Attaching FS and Mounting)
mkfs.xfs /dev/mapper/vg1-lv1
mount /dev/mapper/vg1-lv1 /mnt/storage/
df -h

(Extending LV size)
lvextend -L +50M /dev/vg1/lv1 #can extend without unmounting
xfs_growfs /dev/mapper/vg1-lv1 #extend for XFS
resize2fs /dev/mapper/vg1-lv1 #extend for EXT

(Reducing LV size)
umount /mnt/storage/ #reducing size, can't do it for XFS
fsck -f /dev/mapper/vg1-lv1 #-f=force, for EXT
resize2fs /dev/mapper/vg1-lv1 400M #reduce to size 400M, for EXT
lvreduce -L -200M /dev/mapper/vg1-lv1 #reduce by 200M
mount /dev/mapper/vg1-lv1 /mnt/storage/

(Snapshots)
lvcreate -L 500M -s -n snap1 /dev/mapper/vg1-lv1
mount -o ro /dev/mapper/vg1-snap1 /mnt/backup

(Removing LV)
umount /mnt/storage/ #removing a logical volume
lvremove /dev/vg1/lv1



[ Destroying ]

umount /mnt/Storage 
lvremove /dev/vg1/lv1 
vgremove vg1 
pvremove /dev/sdb1 /dev/sdc1 /dev/sdd1 














