#!/usr/bin/env bash

# Ensure the script is run as root
if [ "$EUID" -ne 0 ]; then
    echo "===================================================="
    echo "ERROR: Please run this script with sudo or as root."
    echo "Example: sudo $0"
    echo "===================================================="
    $(return 0 2>/dev/null) && return 1 || exit 1
fi

echo "Checking network time synchronization service..."

# Detect if timesyncd or chrony is active, if not, try to install systemd-timesyncd
if ! systemctl is-active --quiet systemd-timesyncd && ! systemctl is-active --quiet chrony; then
    echo "⚠️ No active NTP service detected (NTP not supported)."
    echo "📦 Attempting to install systemd-timesyncd automatically..."
    
    apt-get update -qq
    apt-get install -y systemd-timesyncd
    
    if [ $? -eq 0 ]; then
        echo "✅ systemd-timesyncd installed successfully."
        systemctl enable --now systemd-timesyncd
    else
        echo "❌ Failed to install systemd-timesyncd. Attempting chrony fallback..."
        apt-get install -y chrony
        systemctl enable --now chrony
    fi
fi

echo "🔄 Enabling network time synchronization..."
timedatectl set-ntp true 2>/dev/null || chronyc source -a &>/dev/null

echo "⏳ Waiting for synchronization to complete..."
sleep 3

echo "----------------------------------------"
timedatectl status
echo "----------------------------------------"
echo "System time sync completed successfully!"
