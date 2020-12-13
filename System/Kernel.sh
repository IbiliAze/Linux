#!/bin/bash




modprobe #looking for new devices

sudo modprobe -a btusb #turn on bluetooth

sysctl -a #show all paramters passed to the kernel



[ Developing a Kernel ]

yum install -y kernel-devel
yum install -y kernel-doc #for kernel docs for versions < 2.x

ls /usr/src/kernels/ #the current running kernel

ls -al /usr/src/kernels/4.14.203-156.332.amzn2.x86_64/ #documentation
ls -al /usr/share/doc/k* #find the kernel documentation directory

apt-get source linux-image-$(uname -r) #get source code for kernel on ubuntu




yum groupinstall "Development Tools"
yum install ncurses-devel qt-devel hmaccalc zlib-devel binutils-devel elfutils-libelf-devel -y
apt install -y make gcc libncurses5-dev build-dep linux-image-$(uname -r) #for ubuntu
cd /usr/src/kernels/4.14.203-156.332.amzn2.x86_64
make clean #remove everything
make menuconfig #make changes
make bzImage #big Z(ip) image -> vmlinuz
make modules
make modules_install
mv /usr/src/kernels/4.14.203-156.332.amzn2.x86_64/arch/x86/boot/bzImage /boot/vmlinuz-$(uname -r) 
mkinitramfs -o /boot/initrd-4.14.203-156.332.img 4.14.203-156.332 #create initramfs



[ Loadable Kernel Modules ]

ll /lib/modules/4.14.203-156.332.amzn2.x86_64/kernel/ #LKMs

lsmod #loaded modules

rmmod <module name> #remove a module, e.g: rmmod lp

modinfo <module name>
insmod /lib/modules/4.14.203-156.332.amzn2.x86_64/kernel/drivers/amazon/net/ena/ena.ko #load a module with the path provided from the command above

modprobe ena #same as above but only 1 command, instead of 2

modprob lp reset=1 #lp=module, reset=1=>key,value pair found in 'modinfo lp'



[ sysctl ]

vim /etc/sysctl.conf #permanent config



[ System Components ]

lspci

lspci -v #-v=verbose

lspci -vv #-vv=more verbose

lspci -vvv #-vvv=most verbose

lspci -k #-k=kernel drivers handling each device

lsdev

lsusb



[ udev ]

udevadm monitor #listening for device events (USB plugging)



























