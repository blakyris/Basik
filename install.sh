#!/bin/bash

source ./config.sh

loadkeys $KEYMAP
timedatectl set-ntp true

wget -q --spider http://google.com

if [ $? -eq 1 ]
then
  echo -e 'ERROR :: You need to be connected to a network to use this script\n'
  exit 1;
fi

clear
echo -e "******************** WARNING !! **********************\n\n"
echo -e "This script erase all data on your primary hard drive.\n"
echo -e "Would you like to continue ? (Y/n) : "
read ans
if (( ("$year" != "Y") || ("$year" != "y") || ("$year" != "Yes") || ("$year" != "yes") )); then
  echo -e "Aborting..."
  exit 1;
else
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

  cp ./chroot-script.sh /mnt/chroot-scripts.sh
  cp ./config.sh /mnt/config.sh
  arch-chroot /mnt /bin/bash /chroot-scripts.sh

  rm -rf /mnt/tmp/install-scripts/
  reboot
fi
