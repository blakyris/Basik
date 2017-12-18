#!/bin/bash

source ./config.sh

# Install packages you need here...
pacman -Syu --noconfirm --quiet grub \
  efibootmgr \
  net-tools \
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

# Templates & Custom Scripts
#
# Edit "./config.sh" and choose a template or add your scripts directly
# in the custom scripts folder : "./custom-scripts/".

# Desktop template
if [ $TEMPLATE == "DESKTOP_GNOME" ]
then
  source ./templates/desktop_gnome.sh
elif [ $TEMPLATE == "DESKTOP_PLASMA" ]
then
  source ./templates/desktop_plasma.sh
elif [ $TEMPLATE == "SERVER_WEB" ]
then
  source ./templates/server_web.sh
elif [ $TEMPLATE == "SERVER_VIRT" ]
then
  source ./templates/server_virt.sh
else
  echo "No template wiil be installed."
fi
d
source ./custom-scripts/main.sh

exit
