#!/bin/bash

source ./config.sh

loadkeys $KEYMAP
timedatectl set-ntp true

wipefs --force --all /dev/sda
parted --script /dev/sda mklabel gpt
parted --script /dev/sda mkpart ESP fat32 0% 1024MiB
parted --script /dev/sda set 1 boot on
parted --script /dev/sda mkpart primary ext4 1024MiB 100%
parted --script /dev/sda set 2 lvm on

modprobe dm_mod
pvcreate /dev/sda2
vgcreate SYSTEM /dev/sda2
lvcreate -l 100%FREE SYSTEM -n root
vgscan
vgchange -ay

mkfs.vfat -F32 /dev/sda1
mkfs.ext4 /dev/mapper/SYSTEM-root

mount /dev/mapper/SYSTEM-root /mnt
mkdir -p /mnt/boot/
mkdir -p /mnt/boot/efi && mount -t vfat /dev/sda1 /mnt/boot/efi
mkdir -p /mnt/boot/efi/EFI

pacstrap /mnt base base-devel efibootmgr grub net-tools

genfstab -U -p /mnt >> /mnt/etc/fstab

mkdir -p /mnt/usr/bin/basik/
cp -r * /mnt/usr/bin/basik/
arch-chroot /mnt /bin/bash /usr/bin/basik/chroot-script.sh

rm -rf /mnt/usr/bin/basik/

reboot
