import os
cmd = '''rm /etc/wpa_supplicant/wpa_supplicant.conf;
echo "ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
country=FR
network={
    ssid=""
    psk=""
}" > /etc/wpa_supplicant/wpa_supplicant.conf;
sed -i 's:#.*$::g' /etc/wpa_supplicant/wpa_supplicant.conf;
wpa_cli -i wlan0 reconfigure'''
os.system(cmd)
exit()