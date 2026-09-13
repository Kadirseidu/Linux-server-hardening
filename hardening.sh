#!/bin/bash
# Ubuntu 26.04.1 LTS Server Hardening Script
# Author: Kadir Seidu - SysAdmin
# Date: Sep 2026

echo "[+] Starting Security Hardening...."

# Update System
sudo apt update && sudo apt upgrade -y

# Install Tools
sudo apt install ufw fail2ban lynis -y

# Configure Firewall
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 22/tcp
sudo ufw --force enable

# Harden SSH
sudo sed -i 's/#PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
sudo systemctl restart sshd

# Enable Fail2Ban
sudo systemctl enable --now fail2ban

# Run Lynis Audit
echo "[+] Running Security Audit..."
sudo lynis audit system

echo "[+] Hardening Complete!"