#!/bin/bash

source ./config.sh

# Install packages you need here...
pacman -Syu --noconfirm --quiet grub \
  efibootmgr \
  net-tools \
  unbound dnscrypt-proxy \
  openssh \
  ppp \
  emacs-nox


echo $HOSTNAME > /etc/hostname
echo "127.0.1.1 $HOSTNAME.$DOMAIN $HOSTNAME" >> /etc/hosts
rm -f /etc/localtime && ln -s /usr/share/zoneinfo/Europe/Paris /etc/localtime
sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen
locale-gen
echo LANG="$LANG" > /etc/locale.conf
export LANG=$LANG
echo KEYMAP="$KEYMAP" > /etc/vconsole.conf
emacs /etc/mkinitcpio.conf
mkinitcpio -p linux
grub-install --target=x86_64-efi --efi-directory=/boot/efi/ --bootloader-id=linux
grub-mkconfig -o /boot/grub/grub.cfg
passwd
groupadd admin
useradd -g users -m -s /bin/bash $USERNAME
usermod -aG admin $USERNAME
passwd $USERNAME
exit
