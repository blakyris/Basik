#!/bin/bash

echo "Installing required packages..."
pacman --noconfirm --noprogressbar --quiet -Sy unzip

echo "Downloading latest installation scripts from GitHub..."
wget https://github.com/blakyris/Basik/archive/master.zip

# if [ $? -eq 1 ]
#then
#  echo -e "ERROR :: You need to be connected to a network to use this script.\n"
#  exit 1
#fi

unzip master.zip
cd Basik-master
chmod +x *.sh

clear
echo -e "******************** WARNING !! **********************\n\n"
echo -e "This script erase all data on your primary hard drive.\n"
echo -e "Would you like to continue ? (Y/n) : "
read ans
if [ $ans != "Y" || $ans != "y" || $ans != "Yes" || $ans != "yes" ] then
  echo -e "Aborting..."
  exit 1;
else
  echo "Starting Basik installation scripts..."
  ./install.sh
fi
