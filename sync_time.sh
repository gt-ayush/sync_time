#!/usr/bin/env bash

# Ensure the script is run as root
if [ "$EUID" -ne 0 ]; then
    echo "Error: Please run this script with sudo or as root."
    exit 1
fi

echo "Enabling network time synchronization..."
timedatectl set-ntp true

# Give systemd-timesyncd a moment to reach out to NTP servers
echo "Waiting for synchronization to complete..."
sleep 3

# Display current status
echo "----------------------------------------"
timedatectl status
echo "----------------------------------------"
echo "System time sync completed."
