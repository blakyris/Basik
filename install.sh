#!/bin/bash

source ./config.sh

loadkeys fr-pc
timedatectl set-ntp true

wget -q --spider http://google.com

if [ $? -eq 0 ]
then
  echo "ERROR :: You need to connect to a network to use this script\n"
  exit 1;
fi

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

cat ./chroot-script.sh > /chroot-script.sh
cat ./config.sh > /config.sh
arch-chroot /mnt /bin/bash -e -x /chroot-script.sh

rm -rf /mnt/tmp/install-scripts/
reboot
