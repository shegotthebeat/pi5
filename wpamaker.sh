#!/bin/bash

# This script creates the wpa_supplicant.conf file with predefined Wi-Fi networks.

echo "Creating /etc/wpa_supplicant/wpa_supplicant.conf..."
sudo bash -c 'cat <<EOF > /etc/wpa_supplicant/wpa_supplicant.conf
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
country=US

network={
    ssid="AmberlyPlace_Staff"
    psk="AmberlyPlaceStaff"
    priority=10
}
network={
    ssid="RB"
    psk="Remygirl1738"
    priority=5
}
network={
    ssid="KeviniPhone"
    psk="KeviniPhone2025"
    priority=3
}
EOF'

echo "wpa_supplicant.conf created successfully."
echo "You may need to reboot or restart the networking service for changes to take effect."
