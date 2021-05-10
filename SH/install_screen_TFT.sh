#!/bin/bash

# https://github.com/goodtft/LCD-show/blob/master/system_backup.sh
../SRC/screen_TFT/SH/system_backup.sh

if [ -f /etc/X11/xorg.conf.d/40-libinput.conf ]; then
    rm -rf /etc/X11/xorg.conf.d/40-libinput.conf
fi

if [ ! -d /etc/X11/xorg.conf.d ]; then
    mkdir -p /etc/X11/xorg.conf.d
fi
cp ../SRC/screen_TFT/usr/mhs35-overlay.dtb /boot/overlays/
cp ../SRC/screen_TFT/usr/mhs35-overlay.dtb /boot/overlays/mhs35.dtbo

root_dev=`grep -oPr "root=[^\s]*" /boot/cmdline.txt | awk -F= '{printf $NF}'`
if test "$root_dev" = "/dev/mmcblk0p7";then
    cp -rf ../SRC/screen_TFT/boot/config-noobs-nomal.txt ../SRC/screen_TFT/boot/config.txt.bak
else
    cp -rf ../SRC/screen_TFT/boot/config-nomal.txt ../SRC/screen_TFT/boot/config.txt.bak
    echo "hdmi_force_hotplug=1" >> ../SRC/screen_TFT/boot/config.txt.bak
fi
echo "dtparam=i2c_arm=on" >> ../SRC/screen_TFT/boot/config.txt.bak
echo "dtparam=spi=on" >> ../SRC/screen_TFT/boot/config.txt.bak
echo "enable_uart=1" >> ../SRC/screen_TFT/boot/config.txt.bak
echo "dtoverlay=mhs35:rotate=90" >> ../SRC/screen_TFT/boot/config.txt.bak
echo "hdmi_group=2" >> ../SRC/screen_TFT/boot/config.txt.bak
echo "hdmi_mode=1" >> ../SRC/screen_TFT/boot/config.txt.bak
echo "hdmi_mode=87" >> ../SRC/screen_TFT/boot/config.txt.bak
echo "hdmi_cvt 480 320 60 6 0 0 0" >> ../SRC/screen_TFT/boot/config.txt.bak
echo "hdmi_drive=2" >> ../SRC/screen_TFT/boot/config.txt.bak
cp -rf ../SRC/screen_TFT/boot/config.txt.bak /boot/config.txt

cp -rf ../SRC/screen_TFT/usr/99-calibration.conf-mhs35-90  /etc/X11/xorg.conf.d/99-calibration.conf
cp -rf ../SRC/screen_TFT/usr/99-fbturbo.conf  /usr/share/X11/xorg.conf.d/99-fbturbo.conf
if test "$root_dev" = "/dev/mmcblk0p7";then
    cp ../SRC/screen_TFT/usr/cmdline.txt-noobs /boot/cmdline.txt
else
    cp ../SRC/screen_TFT/usr/cmdline.txt /boot/
fi
cp ../SRC/screen_TFT/usr/inittab /etc/
#cp ../SRC/screen_TFT/boot/config-mhs35.txt /boot/config.txt
touch ./.have_installed
echo "gpio:resistance:mhs35:90:480:320" > ./.have_installed

#FBCP install
cp -rf ../SRC/screen_TFT/usr/99-fbturbo-fbcp.conf  /usr/share/X11/xorg.conf.d/99-fbturbo.conf
cp -rf ./etc/rc.local /etc/rc.local
apt-get install git cmake -y 2> error_output.txt
result=`cat ./error_output.txt`
echo -e "\033[31m$result\033[0m"
grep -q "^E:" ./error_output.txt && exit
rm -rf rpi-fbcp
git clone https://github.com/tasanakorn/rpi-fbcp
mkdir ./rpi-fbcp/build
cd ./rpi-fbcp/build/
cmake ..
make
install fbcp /usr/local/bin/fbcp
cd - > /dev/null

#evdev install
#nodeplatform=`uname -n`
#kernel=`uname -r`
version=`uname -v`
#if test "$nodeplatform" = "raspberrypi";then
#echo "this is raspberrypi kernel"
version=${version##* }
#version=${version#*#}
echo $version
if test $version -lt 2017;then
    echo "reboot"
else
    echo "need to update touch configuration"
    dpkg -i -B ./xserver-xorg-input-evdev_1%3a2.10.6-1+b1_armhf.deb 2> error_output.txt
    #apt-get install xserver-xorg-input-evdev  2> error_output.txt
    result=`cat ./error_output.txt`
    echo -e "\033[31m$result\033[0m"
    grep -q "error:" ./error_output.txt && exit
    cp -rf /usr/share/X11/xorg.conf.d/10-evdev.conf /usr/share/X11/xorg.conf.d/45-evdev.conf
    #echo "reboot"
    fi
#else
#echo "this is not raspberrypi kernel, no need to update touch configure, reboot"
#fi

sync
sync
sleep 1
if [ $# -eq 1 ]; then
    ./rotate.sh $1
elif [ $# -gt 1 ]; then
    echo "Too many parameters"
fi

#echo "reboot now"
#reboot