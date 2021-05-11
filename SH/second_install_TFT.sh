#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

deluser --remove-all-files pi





# bluetoothctl
# power on
# scan on

# echo -e '\e[32m=> \e[94mInstalling BLE Drivers.\e[39m'
# mkdir /loot
# cryptsetup -q -v --type luks1 -c aes-xts-plain64 -s 512 --hash sha512 -i 5000 --use-random luksFormat /dev/sda1
# chmod +x /open.sh /close.sh
# ./open.sh #CF open.sh
# ./close.sh #CF close.sh