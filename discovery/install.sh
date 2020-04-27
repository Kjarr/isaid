#!/bin/bash

pacman -S --needed --noconfirm avahi nss-mdns smbclient

# Samba config
mkdir /etc/samba
touch /etc/samba/smb.conf

# Avahi provides local hostname resolution using a "hostname.local" naming scheme
sed -i '/hosts:/s/mymachines/mymachines mdns_minimal [NOTFOUND=return]/' /etc/nsswitch.conf