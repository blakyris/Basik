#!/bin/bash

echo "Installing required packages..."
pacman --noconfirm --noprogressbar --quiet -Sy unzip

wget -q --spider http://archlinux.org
if [ $? -eq 1 ]; then
  echo -e 'ERROR :: You need to be connected to a network to use this script\n'
  exit 1
fi

echo "Downloading latest installation scripts from GitHub..."
wget https://github.com/blakyris/Basik/archive/master.zip

unzip master.zip
cd Basik-master
chmod +x *.sh

clear
echo -e "******************** WARNING !! **********************\n"
echo -e "This script erase all data on your primary hard drive."
echo -e "Would you like to continue ? (Y/n) : "
read ans
if [ $ans == "Y" ] || [ $ans == "y" ] || [ $ans == "Yes" ] || [ $ans == "yes" ]
then
  echo -e "Starting Basik installation scripts..."
  ./install.sh
else
  echo -e "Aborting..."
  exit 1
fi
