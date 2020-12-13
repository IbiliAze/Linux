#!/bin/bash


systemd
^
initrd (initramfs) / Kernel > initrd is which RAM disk to use, vmlinux is the kernel
^
GRUB2 > bootloader, OS loader, points to initrd (initramfs)
^
MBR
^
BIOS > initialises hardware, find the bootloader



systemd
^
initrd / Kernel > initrd is which RAM disk to use, vmlinux is the kernel
^
GRUB2 > EFI Boot-Loader
^
UEFI


vim /etc/grub.d/40_custom #1st
/etc/grub.d/40_custoqm 
/boot/efi/EFI/centos
grub2-mkconfig 