#!/bin/bash

source ./config.sh

loadkeys fr-pc
timedatectl set-ntp true

parted --script /dev/sda mklabel gpt
cgdisk /dev/sda

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

cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
sed -s 's/^#Server/Server/' /etc/pacman.d/mirrorlist.backup
rankmirrors -n 10 /etc/pacman.d/mirrorlist.backup > /etc/pacman.d/mirrorlist
pacstrap /mnt base base-devel

genfstab -U -p /mnt >> /mnt/etc/fstab

mkdir -p /mnt/tmp/
mkdir -p /mnt/tmp/install-scripts
cp ./* /mnt/tmp/install-scripts/
arch-chroot /mnt /tmp/install-scripts/chroot-script.sh

rm -rf /mnt/tmp/install-scripts/
reboot
