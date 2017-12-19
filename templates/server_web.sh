#!/bin/bash

SRC=/bin/basik
source $SRC/config.sh

echo "Installing NGINX, PHP and MySAL..."

pacman -Sy nginx php php-fpm mariadb

systemctl enable nginx
systemctl enable php-fpm
