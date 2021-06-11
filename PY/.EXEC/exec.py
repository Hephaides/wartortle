import os
cmd = '''sudo echo "ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
country=FR
network={
    ssid="ESGI"
    psk="Reseau-GES"
}" > /etc/wpa_supplicant/wpa_supplicant.conf;
sudo reboot'''
os.system(cmd)
exit()