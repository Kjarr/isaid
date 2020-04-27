#!/bin/bash

pacman -S --needed --noconfirm ufw

# Enable UFW
systemctl enable ufw
ufw default deny
ufw enable