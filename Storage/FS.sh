#!/bin/bash



[ Informational ]

man mkfs

ls /usr/sbin/mkfs* #which fs your distro supports

df -h #how much space

fuser / #what is using the root directory

blkid #get the device ID before mounting on fstab



[ Formatting ] 

sudo mkfs.xfs /dev/sda2 #format a disk as xfs

sudo mkswap /dev/sdb3 #for swap
sudo swapon /dev/sdb3 #use swap



[ Labelling ]

sudo e2label /dev/sdb1 PublicStorage #set a label for ext

sudo xfs_admin -L PrivateStorage /dev/sdb2 #set a label for xfs



[ Mounting ]

{Informational}
mount #see the mounted volumes

cat /etc/mtab #same as above

cat /proc/mounts #same as above, more up-to-date, managed by the kernel


{Mounting}
mkdir /mnt/Public
sudo mount /dev/sdb1 /mnt/Public #temporary, will unmount after reboot
mount #list the mounted devices

blkid #get the device ID before mounting on fstab
less /etc/fstab #the list of devices to mount when booting
sudo vim /etc/fstab #persistent mount
    >/dev/sdb1 /mnt/Public ext4 defaults 0 0 #1st 0=won't include the dump utility, 2nd 0=highest priority, order the disks will be checked
    # OR
    >label=Public /mnt/Public ext4 defaults 0 0 #useful when swapping disks
    # OR
    >UUID=00342434746742374746c /mnt/Public ext4 defaults 0 0 #more stable way to mount with devide uuid
mount -a #mount all filesystems mentioned in fstab


{Unmounting}
fuser / #what is using the root directory

fuser -k /mydir #-k=kill, for whatever is using it before unmounting

umount /mnt/data

umount -f /mnt/data #-f=force


{Remounting}
mount -o remount,ro /mnt/data #-o=options, ro=read-only

mount -o remount,rw /mnt/data



[ swap ]

swapon #turn on swap
mkswap /dev/sda1 #prepare the device for swap
blkid #copy the UUID of the partition as shown below
echo 'UUID=053ed8ea-c01c-4519-85a4-aa8710a02e67     swap    swap    defaults    0   0' >> /etc/fstab
swapon -a #activate all swap devices

swapon -s #show swap devices

top #information on swap space

swapoff -a #-a=deactivate all swap devices


{swapfile} #swap with a file rather than disk partition
dd if=/dev/zero of=/root/myswapfile bs=1M count=1024M #if=input file, /dev/zero=allow to fill up the space with zeros, of=output file, \
    #bs=block size, count=size of swap space, (use the /root/myswapfile file and fill it up with zeros to be used for swap)
mkswap /root/myswapfile
echo '/root/myswapfile     swap    swap    defaults    0   0' >> /etc/fstab
swapon -a #activate all swap devices



[ Checks ]

{EXT}
umount /mnt/data
fsck /dev/sda1 #file system check for EXT

fsck /dev/sda1 --force #file system check without unmounting for EXT

dumpe2fs /dev/sda1 #file system & block information for EXT

dumpe2fs -h /dev/sda1 #file system information for EXT

tune2fs #for tuning EXT file systems

tune2fs -m 0 /dev/sda1 #-m=% of reserved blocks for the super user

debugfs /dev/sda1 #interactive prompt
    > ls #run commands like 'ls' in the file system
    > stat somefile.txt #give details of a file
    > q #quit


{XFS}
umount /mnt/data
xfs_repair /dev/sda1 #file system check for XFS

umount /mnt/data
xfs_repair /dev/sda1 #only a check, no replair

xfs_info /dev/sda1 #file system info for XFS
 
mkdir /mnt/backup #backup destination
xfsdump -f /mnt/backup/oldetc /mnt/data #-f=destination, /mnt/data=actual XFS FS,
    -> DecBackUpOfETC #label (name)
    -> MyBackUp #location to back up to
ll /mnt/backup/ #binary data of a backup

mkdir /mnt/restore
xfsrestore -f /mnt/backup/oldetc /mnt/restore/ #restore a backup
ll /mnt/restore/backup

xfsrestore -I #-I=information, backup information



[ Tuning ]

tune2fs #for tuning EXT file systems

tune2fs -m 0 /dev/sda1 #-m=% of reserved blocks for the super user



[ Backup & Restore ]

{XFS:Backup}
mkdir /mnt/backup #backup destination
xfsdump -f /mnt/backup/oldetc /mnt/data #-f=destination, /mnt/data=actual XFS FS,
    -> DecBackUpOfETC #label (name)
    -> MyBackUp #location to back up to
ll /mnt/backup/ #binary data of a backup


{XFS:Restore}
mkdir /mnt/restore
xfsrestore -f /mnt/backup/oldetc /mnt/restore/ #restore a backup
ll /mnt/restore/backup

xfsrestore -I #-I=information, backup information



[ mkisofs & loopbacks ]

{open up an ISO file, read-only}
mkdir /mnt/orig
mount ./my-dist-installer.iso -o loop /mnt/orig #-o=options
ls /mnt/orig #now you can investigate the ISO file


{write an ISO}
yum install -y mkisofs
touch ./backup/file{1..100}.bin #test data to back up
mkisofs --quiet -o mine.iso ./backup



[ sync ]

sync #flush cache










