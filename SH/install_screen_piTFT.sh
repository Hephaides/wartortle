#!/usr/bin/env bash

set -e

function print_version() {
    echo "Adafruit PiTFT Helper v0.8.0"
    exit 1
}

function print_help() {
    echo "Usage: $0 -t [pitfttype]"
    echo "    -h            Print this help"
    echo "    -v            Print version information"
    echo "    -u [homedir]  Specify path of primary user's home directory (defaults to /home/pi)"
    echo "    -t [type]     Specify the type of PiTFT: '28r' (PID 1601) or '28c' (PID 1983) or '35r' or '22'"
    echo
    echo "You must specify a type of display."
    exit 1
}

group=ADAFRUIT
function info() {
    system="$1"
    group="${system}"
    shift
    FG="1;32m"
    BG="40m"
    echo -e "[\033[${FG}\033[${BG}${system}\033[0m] $*"
}

function bail() {
    FG="1;31m"
    BG="40m"
    echo -en "[\033[${FG}\033[${BG}${group}\033[0m] "
    if [ -z "$1" ]; then
        echo "Exiting due to error"
    else
        echo "Exiting due to error: $*"
    fi
    exit 1
}

function ask() {
    # http://djm.me/ask
    while true; do

        if [ "${2:-}" = "Y" ]; then
            prompt="Y/n"
            default=Y
        elif [ "${2:-}" = "N" ]; then
            prompt="y/N"
            default=N
        else
            prompt="y/n"
            default=
        fi

        # Ask the question
        read -p "$1 [$prompt] " REPLY

        # Default?
        if [ -z "$REPLY" ]; then
            REPLY=$default
        fi

        # Check if the reply is valid
        case "$REPLY" in
            Y*|y*) return 0 ;;
            N*|n*) return 1 ;;
        esac
    done
}

# update /boot/config.txt with appropriate values
function update_configtxt() {

    if grep -q "adafruit-pitft-helper" "/boot/config.txt"; then
        echo "Already have an adafruit-pitft-helper section in /boot/config.txt."
        echo "Adding new section, but please run:"
        echo "sudo nano /boot/config.txt"
        echo "...and remove any duplicate sections."
    fi

    if [ "${pitfttype}" == "22" ]; then
        # formerly: options fbtft_device name=adafruit22a gpios=dc:25 rotate=270 frequency=32000000
        overlay="dtoverlay=pitft22,rotate=270,speed=32000000,fps=20"
    fi

    if [ "${pitfttype}" == "28r" ]; then
        overlay="dtoverlay=pitft28-resistive,rotate=90,speed=32000000,fps=20"
    fi

    if [ "${pitfttype}" == "28c" ]; then
        overlay="dtoverlay=pitft28c,rotate=90,speed=32000000,fps=20"
    fi

    if [ "${pitfttype}" == "35r" ]; then
        overlay="dtoverlay=pitft35-resistive,rotate=270,speed=25000000,fps=20"
    fi

    date=`date`

    cat >> /boot/config.txt <<EOF

# --- added by adafruit-pitft-helper $date ---
[pi1]
device_tree=bcm2708-rpi-b-plus.dtb
[pi2]
device_tree=bcm2709-rpi-2-b.dtb
[all]
dtparam=spi=on
dtparam=i2c1=on
dtparam=i2c_arm=on
$overlay
# --- end adafruit-pitft-helper $date ---
EOF

}

# currently for '90' rotation only
function update_xorg() {
    mkdir -p /etc/X11/xorg.conf.d

    cat > /etc/X11/xorg.conf.d/99-fbdev.conf <<EOF
Section "Device"
  Identifier "myfb"
  Driver "fbdev"
  Option "fbdev" "/dev/fb1"
EndSection
EOF

    if [ "${pitfttype}" == "28r" ]; then
        cat > /etc/X11/xorg.conf.d/99-calibration.conf <<EOF
Section "InputClass"
        Identifier      "calibration"
        MatchProduct    "stmpe-ts"
        Option  "Calibration"   "3800 200 200 3800"
        Option  "SwapAxes"      "1"
EndSection
EOF
    fi

    if [ "${pitfttype}" == "35r" ]; then
        cat > /etc/X11/xorg.conf.d/99-calibration.conf <<EOF
Section "InputClass"
        Identifier      "calibration"
        MatchProduct    "stmpe-ts"
        Option  "Calibration"   "3800 120 200 3900"
        Option  "SwapAxes"      "1"
EndSection
EOF
    fi

    if [ "${pitfttype}" == "28c" ]; then
        cat > /etc/X11/xorg.conf.d/99-calibration.conf <<EOF
Section "InputClass"
         Identifier "captouch"
         MatchProduct "ft6x06_ts"
         Option "SwapAxes" "1"
         Option "InvertY" "1"
         Option "Calibration" "0 320 0 240"
EndSection
EOF
    fi
}

function update_x11profile() {
    fbturbo_path="/usr/share/X11/xorg.conf.d/99-fbturbo.conf"
    if [ -e $fbturbo_path ]; then
        echo "Moving ${fbturbo_path} to ${target_homedir}"
        mv "$fbturbo_path" "$target_homedir"
    fi

    if grep -xq "export FRAMEBUFFER=/dev/fb1" "${target_homedir}/.profile"; then
        echo "Already had 'export FRAMEBUFFER=/dev/fb1'"
    else
        echo "Adding 'export FRAMEBUFFER=/dev/fb1'"
        cat >> "${target_homedir}/.profile" <<EOF
export FRAMEBUFFER=/dev/fb1
EOF
    fi
}

# currently for '90' rotation only
function update_pointercal() {
    if [ "${pitfttype}" == "28r" ]; then
        cat > /etc/pointercal <<EOF
-30 -5902 22077792 4360 -105 -1038814 65536
EOF
    fi

    if [ "${pitfttype}" == "35r" ]; then
        cat > /etc/pointercal <<EOF
8 -8432 32432138 5699 -112 -965922 65536
EOF
    fi

    if [ "${pitfttype}" == "28c" ]; then
        cat > /etc/pointercal <<EOF
320 65536 0 -65536 0 15728640 65536
EOF
    fi
}

function update_udev() {
    if [ "${pitfttype}" == "28r" ] || [ "${pitfttype}" == "35r" ]; then
        cat > /etc/udev/rules.d/95-stmpe.rules <<EOF
        SUBSYSTEM=="input", ATTRS{name}=="stmpe-ts", ENV{DEVNAME}=="*event*", SYMLINK+="input/touchscreen"
EOF
    fi

    if [ "${pitfttype}" == "28c" ]; then
        cat > /etc/udev/rules.d/95-ft6206.rules <<EOF
        SUBSYSTEM=="input", ATTRS{name}=="ft6x06_ts", ENV{DEVNAME}=="*event*", SYMLINK+="input/touchscreen"
EOF
    fi
}

function install_console() {
    if ! grep -q 'fbcon=map:10 fbcon=font:VGA8x8' /boot/cmdline.txt; then
        echo "Updating /boot/cmdline.txt"
        sed -i 's/rootwait/rootwait fbcon=map:10 fbcon=font:VGA8x8/g' "/boot/cmdline.txt"
    else
        echo "/boot/cmdline.txt already updated"
    fi
    sed -i 's/BLANK_TIME=.*/BLANK_TIME=0/g' "/etc/kbd/config"
    cat > /etc/rc.local <<EOF
#!/bin/sh -e
#
# rc.local
#
# This script is executed at the end of each multiuser runlevel.
# Make sure that the script will "exit 0" on success or any other
# value on error.
#
# In order to enable or disable this script just change the execution
# bits.
#
# By default this script does nothing.

# Print the IP address
_IP=$(hostname -I) || true
if [ "$_IP" ]; then
  printf "My IP address is %s\n" "$_IP"
fi

# disable console blanking on PiTFT
sudo sh -c "TERM=linux setterm -blank 0 >/dev/tty0"

exit 0
EOF
}

function uninstall_console() {
    sed -i 's/rootwait fbcon=map:10 fbcon=font:VGA8x8/rootwait/g' "/boot/cmdline.txt"
    sed -i 's/BLANK_TIME=0/BLANK_TIME=10/g' "/etc/kbd/config"
    echo "Screen blanking time reset to 10 minutes"
    cat > /etc/rc.local <<EOF
#!/bin/sh -e
#
# rc.local
#
# This script is executed at the end of each multiuser runlevel.
# Make sure that the script will "exit 0" on success or any other
# value on error.
#
# In order to enable or disable this script just change the execution
# bits.
#
# By default this script does nothing.

# Print the IP address
_IP=$(hostname -I) || true
if [ "$_IP" ]; then
  printf "My IP address is %s\n" "$_IP"
fi

exit 0
EOF
}

function update_etcmodules() {
    if [ "${pitfttype}" == "28c" ]; then
        ts_module="ft6x06_ts"
    elif [ "${pitfttype}" == "28r" ] || [ "${pitfttype}" == "35r" ]; then
        ts_module="stmpe_ts"
    else
        return 0
    fi

    if grep -xq "$ts_module" "/etc/modules"; then
        echo "Already had $ts_module"
    else
        echo "Adding $ts_module"
        echo "$ts_module" >> /etc/modules
    fi
}

function install_onoffbutton() {
    echo "Adding rpi_power_switch to /etc/modules"
    if grep -xq "rpi_power_switch" "${chr}/etc/modules"; then
        echo "Already had rpi_power_switch"
    else
        echo "Adding rpi_power_switch"
        cat >> /etc/modules <<EOF
rpi_power_switch
EOF
    fi

    echo "Adding rpi_power_switch config to /etc/modprobe.d/adafruit.conf"
    if grep -xq "options rpi_power_switch gpio_pin=23 mode=0" "${chr}/etc/modprobe.d/adafruit.conf"; then
        echo "Already had rpi_power_switch config"
    else
        echo "Adding rpi_power_switch"
        cat >> /etc/modprobe.d/adafruit.conf <<EOF
options rpi_power_switch gpio_pin=23 mode=0
EOF
    fi
}

function update_bootprefs() {
    echo "Turning off boot-to-desktop"
    if [ -e /etc/init.d/lightdm ]; then
      if [ $SYSTEMD -eq 1 ]; then
        systemctl set-default multi-user.target
        ln -fs /lib/systemd/system/getty@.service /etc/systemd/system/getty.target.wants/getty@tty1.service
      else
        update-rc.d lightdm disable 2
        sed /etc/inittab -i -e "s/1:2345:respawn:\/bin\/login -f pi tty1 <\/dev\/tty1 >\/dev\/tty1 2>&1/1:2345:respawn:\/sbin\/getty --noclear 38400 tty1/"
      fi
    fi
}

# MAIN

target_homedir="/home/pi"

args=$(getopt -uo 'hvri:t:o:b:u:' -- $*)
[ $? != 0 ] && print_help
set -- $args

for i
do
    case "$i"
    in
        -h)
            print_help
            ;;
        -v)
            print_version
            ;;
        -u)
            target_homedir="$2"
            echo "Homedir = ${2}"
            shift
            shift
            ;;
        -t)
            pitfttype="$2"
            echo "Type = ${2}"
            shift
            shift
            ;;
    esac
done

if [[ $EUID -ne 0 ]]; then
    bail "adafruit-pitft-helper must be run as root. try: sudo adadfruit-pitft-helper"
fi

# check init system (technique borrowed from raspi-config):
info PITFT 'Checking init system...'
if command -v systemctl > /dev/null && systemctl | grep -q '\-\.mount'; then
  echo "Found systemd"
  SYSTEMD=1
elif [ -f /etc/init.d/cron ] && [ ! -h /etc/init.d/cron ]; then
  echo "Found sysvinit"
  SYSTEMD=0
else
  bail "Unrecognised init system"
fi

if grep -q boot /proc/mounts; then
    echo "/boot is mounted"
else
    echo "/boot must be mounted. if you think it's not, quit here and try: sudo mount /dev/mmcblk0p1 /boot"
    if ask "Continue?"; then
        echo "Proceeding."
    else
        bail "Aborting."
    fi
fi

if [[ ! -e "$target_homedir" || ! -d "$target_homedir" ]]; then
    bail "$target_homedir must be an existing directory (use -u /home/foo to specify)"
fi

if [ "${pitfttype}" != "28r" ] && [ "${pitfttype}" != "28c" ] && [ "${pitfttype}" != "35r" ] && [ "${pitfttype}" != "22" ]; then
    echo "Type must be one of:"
    echo "  '28r' (2.8\" resistive, PID 1601)"
    echo "  '28c' (2.8\" capacitive, PID 1983)"
    echo "  '35r' (3.5\" Resistive)"
    echo "  '22'  (2.2\" no touch)"
    echo
    print_help
fi

info PITFT "Updating X11 default calibration..."
update_xorg || bail "Unable to update /etc/X11/xorg.conf.d/99-calibration.conf"

info PITFT "Updating X11 setup tweaks..."
update_x11profile || bail "Unable to update X11 setup"

info PITFT "Updating TSLib default calibration..."
update_pointercal || bail "Unable to update /etc/pointercal"

info PITFT "Updating SysFS rules for Touchscreen..."
update_udev || bail "Unable to update /etc/udev/rules.d"

# ask for console access
# if ask "Would you like the console to appear on the PiTFT display?"; then
info PITFT "Updating console to PiTFT..."
install_console || bail "Unable to configure console"
# else
#     info PITFT "Making sure console doesn't use PiTFT"
#     uninstall_console || bail "Unable to configure console"
# fi

info PITFT "Updating /etc/modules..."
update_etcmodules || bail "Unable to update /etc/modules"

if [ "${pitfttype}" != "35r" ]; then
    # ask for 'on/off' button
    if ask "Would you like GPIO #23 to act as a on/off button?"; then
        info PITFT "Adding GPIO #23 on/off to PiTFT..."
        install_onoffbutton || bail "Unable to add on/off button"
    fi
fi

# update_bootprefs || bail "Unable to set boot preferences"

info PITFT "Updating /boot/config.txt..."
update_configtxt || bail "Unable to update /boot/config.txt"

info PITFT "Success!"
info PITFT "Notes:"
echo "Please don't run rpi-update, or you'll have to re-install a kernel"
echo "with PiTFT support.  For more info, see:"
echo "https://learn.adafruit.com/adafruit-pitft-28-inch-resistive-touchscreen-display-raspberry-pi/faq"
