# Cross-Platform Time Synchronization Scripts

A collection of lightweight, plug-and-play scripts to automatically repair, update, and synchronize system clocks across **Linux (Debian/Ubuntu/Arch)**, **Windows**, and **macOS**. 

These scripts resolve common time-drift issues, incorrect system offsets after dual-booting, and broken network time connections by forcing an immediate update against reliable Network Time Protocol (NTP) servers.

## 📋 Table of Contents
- [Features](#-features)
- [Repository Structure](#-repository-structure)
- [Usage Instructions](#-usage-instructions)
  - [Linux (Debian/Ubuntu/Arch)](#linux-debianubuntuarch)
  - [Windows](#windows)
  - [macOS](#macos)
- [Troubleshooting Dual-Boot Time Drift](#-troubleshooting-dual-boot-time-drift)
- [License](#-license)

---

## ⚡ Features
- **Privilege Validation:** Every script automatically checks for required administrative or root privileges before attempting execution.
- **Forced Resynchronization:** Bypasses passive background polling intervals to update the local clock instantly.
- **Fail-Safe Fallbacks:** Windows script falls back onto a combined target pool (`time.windows.com` and `pool.ntp.org`) to protect against network drops.
- **Status Reporting:** Prints out diagnostic confirmation states immediately post-execution to verify structural health.

---

## 📂 Repository Structure
```text
├── sync_time.sh        # Linux systems (systemd-timesyncd / timedatectl)
├── sync_time.bat       # Windows environments (w32time / w32tm)
├── sync_time_mac.sh    # macOS platforms (systemsetup / timed)
└── README.md           # Documentation
```

---

## 🚀 Usage Instructions

### Linux (Debian/Ubuntu/Arch)
Designed for distributions running `systemd`. It enables network time management via `timedatectl` and evaluates sync diagnostics.

1. **Make the script executable:**
   ```bash
   chmod +x sync_time.sh
   ```
2. **Execute with root privileges:**
   ```bash
   sudo ./sync_time.sh
   ```

### Windows
Designed for command-prompt architecture. It spins up the Windows Time service (`w32time`), assigns manual peer tracking, and triggers an immediate authoritative recalculation.

1. **Right-click** on `sync_time.bat`.
2. Select **"Run as administrator"**.

### macOS
Designed for Apple devices using `systemsetup` configurations. It turns on network time syncing and sends a termination single to `timed` to force an instant background pull.

1. **Make the script executable:**
   ```bash
   chmod +x sync_time_mac.sh
   ```
2. **Execute with root privileges:**
   ```bash
   sudo ./sync_time_mac.sh
   ```

---

## 🛠️ Troubleshooting Dual-Boot Time Drift

If your system clock drifts by a specific number of hours every time you toggle between Windows and Linux/macOS, it is because of an architectural conflict:
- **Linux/macOS** expects your Hardware Clock (RTC) to store time in **UTC**.
- **Windows** expects your Hardware Clock (RTC) to store time in **Local Time**.

### The Fix
To force your Linux system to read the hardware clock using local time (matching Windows), run this command on your Linux environment:
```bash
sudo timedatectl set-local-rtc 1 --adjust-system-clock
```

---

## 📄 License
This repository is open-source and available under the [MIT License](https://opensource.org/licenses/MIT). Feel free to modify, distribute, or integrate these scripts into your automated environment configurations.
