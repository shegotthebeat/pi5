# pi5 Resurrection Guide

This guide outlines the full recovery process to restore your Raspberry Pi 5 server environment after an SD card failure or reimaging. It assumes you're using a 64-bit Raspberry Pi OS Lite and storing app data/configs externally or in remote repositories.

---

- **Motivation**: Restore Pi5 microserver with Flask apps, Cloudflare tunnel, and environment scripts.
- **Assumptions**: SSD connected, internet available, GitHub access, Cloudflare Tunnel pre-configured.

---

## 1. Flash OS onto SD card

Use **Raspberry Pi Imager** to install:

- **Image**: Raspberry Pi OS Lite (64-bit)
- **Pre-configuration**:
  - ✅ Enable SSH
  - ✅ Configure WiFi (SSID & password)
  - ✅ Define username and password

> ⚠️ These settings are critical for headless access.

---

## 2. Boot and Connect Hardware

- Insert imaged SD card into Pi5
- Attach SSD 
- Power on, maybe wait ~60 seconds

---

## 3. SSH into Pi

```bash
ssh user@pi_hostname_or_ip
```

---

## 4. Update System & Install Git

```bash
sudo apt update && sudo apt install -y git
```
---

## 5. Clone Repositories

```bash
git clone https://github.com/shegotthebeat/csvboxer.git
git clone https://github.com/shegotthebeat/filer.git
git clone https://github.com/shegotthebeat/pi5.git
```
---

## 6. Reconnect to Cloudflare Tunnel (Zero Trust)

```bash
https://dash.cloudflare.com > Zero Trust > Networks > Tunnels
```

Two scenarios:
* Existing tunnel: Select tunnel > Click “Edit” > Follow steps to install package, authenticate with token, and configure as a service.
* New tunnel: Create it > Define public hostnames/subdomains > Follow the auto-generated instructions.

---

## 7. Run Setup Scripts

```bash
cd pi5
chmod +x *.sh
```
Then run the following to automatically detect and execute the .sh scripts in reverse alphabetical order:

```bash
./run_setup.sh
```
---

## 8. Configure WiFi Monitor
 
 ```bash
crontab -e
```
Adding: 
```bash
*/1 * * * * /home/your_user/pi5/wifisustain.sh
```
