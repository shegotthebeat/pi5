#!/bin/bash

# This script checks for internet connectivity and reconfigures the Wi-Fi if needed.

# Ping a reliable public DNS server (Google's)
if ! ping -c 1 8.8.8.8 > /dev/null 2>&1; then
    echo "Internet connection lost. Reconfiguring Wi-Fi..."
    
    # Reconfigure wpa_supplicant with the current configuration file
    sudo wpa_cli -i wlan0 reconfigure

    # Give the system time to reconnect before restarting the service
    sleep 5
    
    # Restart the wpa_supplicant service as a failsafe
    sudo systemctl restart wpa_supplicant
fi
