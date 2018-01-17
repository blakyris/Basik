# Basik - A simple Arch Linux installation script for UEFI based systems

**DISCLAIMER : This script erases all data on your main hard drive  ``` /dev/sda ```. Remember to save ALL data before running this script.
If you want multiple partition or dual boot support, please let me know by email.**
_____________________________________________________________________________________________________________

## Installation

> **NOTE** : 
> - You have to be connected to a network to use this script. If you want offline installation support, please let me know by email.
> - You can customize your system configuration before executing the script by editing the ``` config.sh ``` file using the nano text editor : ``` nano config.sh ```.


1. Boot the official Arch Linux ISO.
2. Get your machine IP address using the ``` ip address show ``` command. If you are using Wi-Fi connection, type ``` wifi-menu ``` to get a GUI connection tool.
3. Change root password : ``` passwd ``` 
4. Start the SSH deamon : ``` systemctl start sshd ``` 
5. Connect via SSH and type the following command :

```
bash <(curl -Ss https://raw.githubusercontent.com/blakyris/Basik/master/script.sh)
```

## Licence

This project is under the GPLv3 Licence
