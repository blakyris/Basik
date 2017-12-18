#!/bin/bash

source ./config.sh

echo "Installing GNOME Desktop..."

pacman -Sy xorg \
  xorg-server-utils \
  gnome \
  gnome-software \
  gnome-tweak-tool \
  gnome-builder \
  firefox

pacman -Rs epiphany empathy
