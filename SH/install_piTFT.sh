#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

echo -e "Don't forget to plug your ubertooth :)"
WPA_SSID=""

echo -e 'Please enter your WPA ESSID.'
read WPA_SSID
echo -e 'Please enter your WPA PASSWORD.'
WPA_CONF=$(wpa_passphrase $WPA_SSID)
WPA_CONF=${WPA_CONF:32}

# echo -e '\e[32m=> \e[94mSetting up interfaces.\e[39m'
# echo "auto wlan0
# iface wlan0 inet manual
# wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf" >> /etc/network/interfaces

echo -e '\e[32m=> \e[94mSetting up wpa_supplicant.\e[39m'
echo "ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
country=FR
$WPA_CONF" > /etc/wpa_supplicant/wpa_supplicant.conf #CF wpa_supplicant.conf
sed -i 's:#.*$::g' /etc/wpa_supplicant/wpa_supplicant.conf
wpa_cli -i wlan0 reconfigure

echo -e '\e[32m=> \e[94mSetting up ssh server.\e[39m'
echo 'Port 2910
PermitRootLogin yes
ChallengeResponseAuthentication no
UsePAM yes
X11Forwarding yes
PrintMotd no
AcceptEnv LANG LC_*
Subsystem sftp /usr/lib/openssh/sftp-server' > /etc/ssh/sshd_config #CF sshd_config

echo -e '\e[32m=> \e[94mUpgrading system.\e[39m'
apt-get update -y && apt-get full-upgrade -y && apt-get upgrade -y && apt-get autoremove -y && apt-get autoclean -y

echo -e '\e[32m=> \e[94mUpgrading firmware.\e[39m'
rpi-update

echo -e '\e[32m=> \e[94mRemoving pi and adding screen.\e[39m'
adduser screen
usermod -aG sudo screen
echo "screen     ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

echo -e '\e[32m=> \e[94mSetting up screen profile.\e[39m'
wget http://51.38.237.141/WARTORTLE/start.py
mv start.py /home/screen/start.py
cd /home/screen
chmod +x start.py
chown screen start.py
chgrp screen start.py
echo 'sudo python3 /home/screen/start.py
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
export FRAMEBUFFER=/dev/fb1' > /home/screen/.profile

echo -e '\e[32m=> \e[94mSetting up the PiTFT.\e[39m'
cd ~
wget http://51.38.237.141/WARTORTLE/install_screen_piTFT.sh #CF install_screen.sh
chmod +x install_screen.sh
./install_screen.sh -u /home/screen -t 35r
rm -rf install_screen.sh

echo -e '\e[32m=> \e[94mInstalling requirements.\e[39m'
apt-get install tmux conspy cryptsetup bluez python3-pip -y
python3 -m pip install pexpect
echo '[Service]
ExecStart=
ExecStart=-/sbin/agetty --autologin screen --noclear %I 38400 linux' > /etc/systemd/system/getty@tty1.service.d/override.conf #CF getty
systemctl enable getty@tty1.service

echo -e '\e[32m=> \e[94mInstalling BLE Drivers.\e[39m'
cd ~
wget http://51.38.237.141/WARTORTLE/rtl8761bu_config
wget http://51.38.237.141/WARTORTLE/rtl8761bu_fw
mv rtl8761bu_fw /lib/firmware/rtl_bt/rtl8761b_fw.bin
mv rtl8761bu_config /lib/firmware/rtl_bt/rtl8761b_config.bin

echo -e '\e[32m=> \e[94mDownloading last script.\e[39m'
wget http://51.38.237.141/WARTORTLE/exploit.py
wget http://51.38.237.141/WARTORTLE/Chocobo.py

echo -e '\e[32m=> \e[94mInstalling UBERTOOTHONE.\e[39m'
apt-get install xorg cmake libusb-1.0-0-dev make gcc g++ libbluetooth-dev wget \
  pkg-config python3-numpy python3-qtpy python3-distutils python3-setuptools p7zip -y
wget https://github.com/greatscottgadgets/libbtbb/archive/2020-12-R1.tar.gz -O libbtbb-2020-12-R1.tar.gz
tar -xf libbtbb-2020-12-R1.tar.gz
cd libbtbb-2020-12-R1
mkdir build
cd build
cmake ..
make
make install
ldconfig
wget https://github.com/greatscottgadgets/ubertooth/releases/download/2020-12-R1/ubertooth-2020-12-R1.tar.xz
tar -xf ubertooth-2020-12-R1.tar.xz
cd ubertooth-2020-12-R1/host
mkdir build
cd build
cmake ..
make
make install
ldconfig
ubertooth-util -v

# ubertooth-dfu -d bluetooth_rxtx.dfu -r
# ubertooth-util -v

mkdir /home/screen/LOOT
mkdir /home/screen/EXPLOITS

cd /home/screen/EXPLOITS
wget http://51.38.237.141/WARTORTLE/wartortle_exploit.7z
p7zip -d wartortle_exploit.7z
mv wartortle_exploit/* .
rm -Rf README.md
rm -Rf wartortle_exploit
chmod +x -R *

cd ..
wget http://51.38.237.141/WARTORTLE/second_install_TFT.sh
echo "Reboot dans quelques secondes, veuillez vous reconnecter avec screen et non pi. Merci"

reboot