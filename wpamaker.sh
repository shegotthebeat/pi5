#!/bin/bash

# This script creates the wpa_supplicant.conf file with predefined Wi-Fi networks.

echo "Creating boot/wpa_supplicant.conf..."
sudo bash -c 'cat <<EOF > boot/wpa_supplicant.conf
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
country=US

network={
    ssid="AmberlyPlace_Staff"
    psk="AmberlyPlaceStaff"
    priority=10
    bgscan="simple:30:-70:300"
}
network={
    ssid="RB"
    psk="Remygirl1738"
    priority=5
    bgscan="simple:30:-70:300"
}
network={
    ssid="KeviniPhone"
    psk="KeviniPhone2025"
    priority=3
    bgscan="simple:30:-70:300"
}
EOF'

echo "wpa_supplicant.conf created successfully."
echo "You may need to reboot or restart the networking service for changes to take effect."
