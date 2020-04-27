#!/bin/bash

pacman -S --needed --noconfirm cups gutenprint ghostscript gsfonts

systemctl enable cups.service