#!/usr/bin/env bash

# Ensure the script is run as root
if [ "$EUID" -ne 0 ]; then
    echo "Error: Please run this script with sudo or as root."
    exit 1
fi

echo "Enabling automatic time and date settings..."
sudo systemsetup -setusingnetworktime on

echo "Forcing an immediate time synchronization..."
# Triggers the native macOS network time daemon to sync
sudo killall timed

# Give it a second to refresh
sleep 2

echo "----------------------------------------"
echo "Current macOS System Time:"
date
echo "----------------------------------------"
echo "System time sync completed."
