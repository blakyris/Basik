# Basik - A simple Arch Linux installation script for UEFI based systems

**DISCLAMER : This script erase all data on your main hard drive  ``` /dev/sda ```. Remember to save ALL data before running this script.
If you want multiple partition or dual boot support, please let me know by email.**
_____________________________________________________________________________________________________________

## Installation

> **NOTE** : 
> - You have to be connected to a network to use this script. If you want offline installation support, please let me know by email.
> - You can customize your system configuration before executing the script by editing the ``` config.sh ``` file using the nano text editor : ``` nano config.sh ```.


1. Boot the official Arch Linux ISO.
2. Get your machine IP address using the ``` ifconfig ``` command.
3. Start the SSH deamon : ``` systemctl start sshd ``` 
3. Connect via SSH and type the following command :

```
bash <(curl -Ss https://raw.githubusercontent.com/blakyris/Basik/master/script.sh)
```

## Licence

This project is under the GPLv3 Licence
