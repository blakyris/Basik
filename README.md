# Basik - A simple Arch Linux installation script for UEFI based systems

**NOTE** : You have to be connected to a network to use this script. If you want offline installation support, please let me know by email.

**DISCLAMER !!**
This script erase all data on your main hard drive -  ``` /dev/sda ```. Remember to save ALL your data before running this script.
If you want multiple partition or dual boot support, please let me know by email.
_____________________________________________________________________________________________________________

## Installation


Boot the official Arch Linux ISO and type the following commands :

```
pacman -Sy unzip
wget https://github.com/blakyris/Basik/archive/master.zip
unzip master.zip
cd Basik-master
chmod +x *.sh
./install.sh
```

You can customize your system configuration before executing the script by editing the ``` config.sh ``` file using the nano text editor : ``` nano config.sh ```.

## Licence

This project is under the GPLv3 Licence
