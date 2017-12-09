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

cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
sed -s 's/^#Server/Server/' /etc/pacman.d/mirrorlist.backup
rankmirrors -n 10 /etc/pacman.d/mirrorlist.backup > /etc/pacman.d/mirrorlist
pacstrap /mnt base base-devel

genfstab -U -p /mnt >> /mnt/etc/fstab

mkdir -p /usr/bin/basik/
cp ./chroot-script.sh /mnt/usr/bin/basik/chroot-scripts.sh
cp ./config.sh /mnt/usr/bin/basik/config.sh
arch-chroot /mnt /bin/bash /chroot-scripts.sh

mkdir -rf /usr/bin/basik/

reboot
