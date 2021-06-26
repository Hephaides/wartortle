#!/usr/bin/env bash
### ==============================================================================
###
### Created by Migoliatte
### Installation of the Rasberry Pi with a Amazon screen ( not official )
###
### ==============================================================================

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)

function help() {
  msg "
          help: $(basename "${BASH_SOURCE[0]}") 
          Script description here.  
          Run this program only one time with root or sudo user
  "
}

function colors_cli() {
        if [[ -t 2 ]] && [[ -z "${NO_COLOR-}" ]] && [[ "${TERM-}" != "dumb" ]]; then
                end_colors='\033[0m' RED='\033[0;31m' GREEN='\033[0;32m' ORANGE='\033[0;33m' BLUE='\033[0;34m' PURPLE='\033[0;35m' CYAN='\033[0;36m' YELLOW='\033[1;33m'
        else
                end_colors='' RED='' GREEN='' ORANGE='' BLUE='' PURPLE='' CYAN='' YELLOW=''
        fi
}

function msg() {
  echo >&2 -e "${1}"
}

function killProgram() {
  msg=$1
  returnCode=${2-1}
  msg "${RED}$msg${end_colors}"
  help
  exit "$returnCode"
}

function test_user(){
  if [ "$EUID" -ne 0 ]
    then killProgram "Please run as root"
  fi
}

function ubertoothVerif() {
  lsusb|grep -i "Ubertooth One"
  ubertoothPlugged=$(echo $?)
  if [ $ubertoothPlugged != 0 ]
    then echo -e "Don't forget to plug your ubertooth :)"
    exit
  else
    echo "Your ubertooth is well plugged, let's continue "
  fi
}

function networkInit(){
  rfkill unblock wifi; rfkill unblock all
  ifconfig wlan0 down
  ifconfig wlan0 up
  iw wlan0 scan|grep -i "SSID:"
  WPA_SSID=""
  msg "${ORANGE} Please enter your WPA ESSID. ${end_colors}"
  read WPA_SSID
  msg "${ORANGE} Please enter your WPA PASSWORD. ${end_colors}"
  WPA_CONF=$(wpa_passphrase "$WPA_SSID")
  WPA_CONF=${WPA_CONF:32}
  msg "${BLUE} Setting up wpa_supplicant${end_colors}"
  echo "ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
  update_config=1
  country=FR
  $WPA_CONF" > /etc/wpa_supplicant/wpa_supplicant.conf
  sed -i 's:#.*$::g' /etc/wpa_supplicant/wpa_supplicant.conf
  wpa_cli -i wlan0 reconfigure
}

function sshInit(){
  msg "${BLUE} Setting up ssh server..${end_colors}"
  echo 'Port 2910
  PermitRootLogin no
  ChallengeResponseAuthentication no
  UsePAM yes
  X11Forwarding no
  PrintMotd no
  AcceptEnv LANG LC_*
  Subsystem sftp /usr/lib/openssh/sftp-server' > /etc/ssh/sshd_config
}

function systemUpdates(){
  msg "${BLUE}Upgrading system.${end_colors}"
  apt-get update -y && apt-get full-upgrade -y && apt-get upgrade -y && apt-get autoremove -y && apt-get autoclean -y
  msg "${BLUE} 94mUpgrading firmware.${end_colors}"
  echo "y"|rpi-update
  sg "${BLUE}Installing requirements.${end_colors}"
  echo "y"|apt-get install tmux conspy cryptsetup bluez python3-pip -y
  python3 -m pip install pexpect
}

function screenCreation(){
  msg "${BLUE}adding screen.${end_colors}"
  adduser screen
  usermod -aG sudo screen
  echo "screen     ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
}

function screenDisplaySetting(){
  msg "${BLUE} screen setting. ${end_colors}"
  systemctl disable lightdm.service
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
  echo '[Service]
  ExecStart=
  ExecStart=-/sbin/agetty --autologin screen --noclear %I 38400 linux' > /etc/systemd/system/getty@tty1.service.d/override.conf #CF getty
  systemctl enable getty@tty1.service
}

function bleDriverInit(){
  msg "${BLUE} Installing BLE Drivers. ${end_colors}"
  cd ~
  wget http://51.38.237.141/WARTORTLE/rtl8761bu_config
  wget http://51.38.237.141/WARTORTLE/rtl8761bu_fw
  mv rtl8761bu_fw /lib/firmware/rtl_bt/rtl8761b_fw.bin
  mv rtl8761bu_config /lib/firmware/rtl_bt/rtl8761b_config.bin

  msg "${BLUE} Download scripts. ${end_colors}"
  wget http://51.38.237.141/WARTORTLE/exploit.py
  wget http://51.38.237.141/WARTORTLE/Chocobo.py

  msg "${BLUE} Installing UBERTOOTHONE. ${end_colors}"
  apt-get install xorg cmake libusb-1.0-0-dev make gcc g++ libbluetooth-dev wget \
    pkg-config python3-numpy python3-qtpy python3-distutils python3-setuptools -y
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
  

}

function ubertoothUpdated(){
  ubertooth-util -v|grep -i "2018"
  ubertoothUpdated=$(echo $?)
  if [ $ubertoothUpdated == 0 ]
    then
    echo -e "Your Ubertooth need an update, let's do it :)"
    cd ../../ubertooth-one-firmware-bin/
    ubertooth-dfu -d bluetooth_rxtx.dfu -r
  else
    echo "Your ubertooth is already well update, let's finish"
  fi
}

function main() {
  ubertoothVerif
  networkInit
  sshInit
  systemUpdates
  screenCreation
  screenDisplaySetting
  bleDriverInit
  ubertoothUpdated

  echo "Reboot dans quelques secondes, veuillez vous reconnecter avec screen et non pi. Merci"
  echo "lancez 'deluser --remove-all-files pi' au prochain boot"
  cp -r /home/pi/ /root/
  cd /root/pi/LCD-show/ && sudo ./LCD35-show 180
}

main 