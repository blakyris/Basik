#!/bin/bash

echo "Ranking pacman mirrors..."
pacman --noconfirm --noprogressbar -Sy pacman-contrib
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
sed -s 's/^#Server/Server/' /etc/pacman.d/mirrorlist.backup
rankmirrors -n 10 /etc/pacman.d/mirrorlist.backup > /etc/pacman.d/mirrorlist

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

clear && clear
cat ./welcome.txt
echo -e ""
echo -n "Press [ENTER] to continue..."
read ret

clear
echo -e ""
echo -e "/!\ CAUTION !!! DATA LOSS CAN OCCURE. READ CAREFULLY !"
echo -e "    --------------------------------------------------"
echo -e ""
echo -e "Multiple partitions and dual boot is not supported yet."
echo -e "This script erase all data on your primary hard drive (/dev/sda) !!"
echo -e "If you are not sure about what you are doing say no."
echo -n "Would you like to continue ? (Y/n) : "
read ans
if [ $ans == "Y" ] || [ $ans == "y" ] || [ $ans == "Yes" ] || [ $ans == "yes" ]
then
  unset ans
  echo -e ""
  echo -e ""
  echo -e ">> CUSTOMIZE YOUR INSTALLATION"
  echo -e "   ---------------------------"
  echo -e ""
  echo -e "You can customize your system settings before running the scripts"
  echo -n "Would you like to edit the configuration file ? (Y/n) : "
  read ans
  if [ $ans == "Y" ] || [ $ans == "y" ] || [ $ans == "Yes" ] || [ $ans == "yes" ]
  then
    nano config.sh
  fi

  ./install.sh
else
  echo -e "Aborted."
  exit 1;
fi
