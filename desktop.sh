#!/bin/bash

# General services
pacman -S --needed --noconfirm acpi acpid

# Graphics
pacman -S --needed --noconfirm xorg xorg-xinit mesa picom

# Audio
pacman -S --needed --noconfirm pulseaudio pulseaudio-alsa

# Fonts
pacman -S --needed --noconfirm ttf-droid ttf-ionicons ttf-dejavu

# Themes and Icons
pacman -S --needed --noconfirm arc-gtk-theme hicolor-icon-theme papirus-icon-theme

# Desktop envoirement
PKGS=(
    dmenu
    dunst
    evince
    feh
    file-roller unrar p7zip lrzip
    firefox
    gnome-calculator
    gparted dosfstools ntfs-3g mtools
    i3-gaps i3status i3lock
    lxrandr
    mpv
    network-manager-applet
    pavucontrol
    pcmanfm-gtk3 gvfs udisks2 libmtp mtpfs gvfs-mtp
    ranger w3m highlight
    rxvt-unicode
    scrot
    tmux
)
pacman -S --needed --noconfirm "${PKGS[@]}"

# TODO: add dotfiles, acpid enable acpid.service
