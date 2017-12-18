#!/bin/bash

source ./config.sh

echo "Installing GNOME Desktop..."

pacman --noconfirm --noprogressbar -Sy xorg \
  xorg-server-utils \
  gnome \
  gnome-software \
  gnome-tweak-tool \
  gnome-builder \
  firefox

pacman --noconfirm --noprogressbar -Rs epiphany empathy
