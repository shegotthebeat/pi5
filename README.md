# Raspberry Pi 5 - Server-in-My-Pocket 🔧 Resurrection Guide

This guide outlines the full recovery process to restore your Raspberry Pi 5 server environment after an SD card failure or reimaging. It assumes you're using a 64-bit Raspberry Pi OS Lite and storing app data/configs externally or in remote repositories.

---

## 🚀 Quick Summary

- **Purpose**: Restore Pi5 microserver with Flask apps, Cloudflare tunnel, and environment scripts.
- **Precondition**: SSD connected, internet available, GitHub access, Cloudflare Tunnel pre-configured.

---

## 1. Flash OS and Configure Network

Use **Raspberry Pi Imager** to install:

- **Image**: Raspberry Pi OS Lite (64-bit)
- **Pre-configuration**:
  - ✅ Enable SSH
  - ✅ Configure WiFi (SSID & password)
  - ✅ Define username and password

> ⚠️ These settings are critical for headless access.

---

## 2. Boot and Connect Hardware

- Insert the imaged SD card into the Pi5
- Attach SSD (containing persistent storage or apps if needed)
- Power on and wait ~60 seconds

---

## 3. SSH into Your Pi

From your main machine:
```bash
ssh your_user@your_pi_hostname_or_ip
