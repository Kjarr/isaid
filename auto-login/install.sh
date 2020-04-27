#!/bin/bash

# Enable auto login on tty1
mkdir -p /etc/systemd/system/getty@tty1.service.d/
echo "[Service]" > /etc/systemd/system/getty@tty1.service.d/override.conf
echo "ExecStart=" >> /etc/systemd/system/getty@tty1.service.d/override.conf
echo "ExecStart=/usr/bin/agetty --autologin $SUDO_USER --noclear %I \$TERM" >> /etc/systemd/system/getty@tty1.service.d/override.conf