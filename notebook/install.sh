#!/bin/bash

pacman -S --needed --noconfirm tlp brightnessctl

# Enable TLP
systemctl enable tlp.service
systemctl mask systemd-rfkill.service
systemctl mask systemd-rfkill.socket