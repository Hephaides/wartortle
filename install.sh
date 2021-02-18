#INSTALL RASP
sudo nano /etc/wpa_supplicant/wpa_supplicant.conf #CF wpa_supplicant.conf
sudo wpa_cli -i wlan0 reconfigure
sudo nano /etc/ssh/sshd_config #CF sshd_config
reboot
apt-get update -y && apt-get full-upgrade -y && apt-get upgrade -y && apt-get autoremove -y && apt-get autoclean -y
rpi-update
reboot
deluser --remove-all-files pi
reboot
adduser screen
usermod -aG sudo screen
nano /home/screen/start.py #CF start.py
chmod +x start.py
chown screen start.py
chgrp screen start.py
nano install_screen.sh #CF install_screen.sh
chmod +x install_screen.sh
./install_screen.sh -u /home/screen -t 35r
reboot
apt-get install tmux conspy cryptsetup gattool bluez python3-pip -y
python3 -m pip install pexpect
systemctl edit getty@tty1 #CF getty
systemctl enable getty@tty1.service
nano /home/screen/.profile
reboot

#UBERTOOTH
apt-get install xorg cmake libusb-1.0-0-dev make gcc g++ libbluetooth-dev wget \
  pkg-config python3-numpy python3-qtpy python3-distutils python3-setuptools
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

#BLE
wget https://mpow.s3-us-west-1.amazonaws.com/20201202_mpow_BH456A_driver+for+Linux.7z
apt-get install p7zip*
7z x 20201202_mpow_BH456A_driver+for+Linux.7z
cp 20201202_LINUX_BT_DRIVER/rtkbt-firmware/lib/firmware/rtl8761bu_fw /lib/firmware/rtl_bt/rtl8761b_fw.bin
cp 20201202_LINUX_BT_DRIVER/rtkbt-firmware/lib/firmware/rtl8761bu_config /lib/firmware/rtl_bt/rtl8761b_config.bin
bluetoothctl
power on
scan on

#CRYPTSETUP
mkdir /loot
cryptsetup -q -v --type luks1 -c aes-xts-plain64 -s 512 --hash sha512 -i 5000 --use-random luksFormat /dev/sda1
chmod +x /open.sh /close.sh
./open.sh #CF open.sh
./close.sh #CF close.sh