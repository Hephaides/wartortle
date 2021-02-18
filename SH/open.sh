cryptsetup -c aes-xts-plain64 -s 512 -o 0 open /dev/sda1 c_sda1
mount /dev/mapper/c_sda1 /loot