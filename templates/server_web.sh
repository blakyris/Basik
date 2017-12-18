#!/bin/bash

source ./config.sh

echo "Installing NGINX, PHP and MySAL..."

pacman -Sy nginx php php-fpm mariadb
