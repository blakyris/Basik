#!/bin/bash

echo "Installing GNOME Desktop..."

pacman --noconfirm --noprogressbar -Sy xorg \
  xorg-server-utils \
  gnome \
  gnome-software \
  gnome-tweak-tool \
  gnome-builder \
  firefox

systemctl enable gdm
systemctl enable NetworkManager
