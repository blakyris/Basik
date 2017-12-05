#!/bin/bash

source ./config.sh

echo $HOSTNAME > /etc/hostname
echo "127.0.1.1 $HOSTNAME.$DOMAIN $HOSTNAME" >> /etc/hosts
ln -s /usr/share/zoneinfo/Europe/Paris /etc/localtime
echo $LOCALE > /etc/locale.gen
locale-gen
echo LANG="$LANG" > /etc/locale.conf
export LANG=$LANG
echo KEYMAP="$KEYMAP" > /etc/vconsole.conf
emacs /etc/mkinitcpio.conf
mkinitcpio -p linux
grub-install --target=x86_64-efi --efi-directory=/boot/efi/ --bootloader-id=linux
grub-mkconfig -o /boot/grub/grub.cfg
passwd
groupadd users
groupadd admin
useradd -g users -m -s /bin/bash $USERNAME
usermod -aG admin $USERNAME
passwd $USERNAME
exit
