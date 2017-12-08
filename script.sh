#!/bin/bash

ret=""

echo "Installing required packages..."
pacman --noconfirm --noprogressbar -Sy unzip

wget -q --spider http://archlinux.org
if [ $? -eq 1 ];
then
  echo -e 'ERROR :: You need to be connected to a network to use this script\n'
  exit 1;
fi

echo "Downloading latest installation scripts from GitHub."
wget -q https://github.com/blakyris/Basik/archive/master.zip

unzip -qq master.zip
cd Basik-master
chmod +x *.sh

clear
cat ./welcome.txt
echo -e "Press [ENTER] to continue..."
read ret

clear
echo -e "\n/!\ CAUTION !!! DATA LOSS CAN OCCURE. READ CAREFULLY !"
echo -e "    --------------------------------------------------"
echo -e "Multiple partitions and dual boot is not supported yet."
echo -e "This script erase all data on your primary hard drive (/dev/sda) !!"
echo -e "Would you like to continue ? (Y/n) : "
read ans
if [ $ans == "Y" ] || [ $ans == "y" ] || [ $ans == "Yes" ] || [ $ans == "yes" ]
then
  unset ans

  echo -e ">> CUSTOMIZE YOUR INSTALLATION"
  echo -e "   ---------------------------"
  echo -e "You can customize your system settings before running the scripts"
  echo -n "Would you like to edit the configuration file ? (Y/n) : "
  read ans
  if [ $ans == "Y" ] || [ $ans == "y" ] || [ $ans == "Yes" ] || [ $ans == "yes" ]
  then
    nano config.sh
  fi

  ./install.sh
else
  echo -e "Aborting..."
  exit 1;
fi
