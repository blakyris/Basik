#!/bin/bash

echo "Installing required packages..."
pacman --noconfirm --noprogressbar --quiet -Sy unzip

echo "Downloading latest installation scripts from GitHub..."
wget https://github.com/blakyris/Basik/archive/master.zip
if [ $? -eq 1 ] then
  echo "ERROR :: You need to be connected to a network to use this script\n"
  exit 1;
fi

unzip master.zip
cd Basik-master
chmod +x *.sh

echo "Starting Basik installation scripts..."
./install.sh
