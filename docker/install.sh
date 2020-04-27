#!/bin/bash

pacman -S --needed --noconfirm docker

usermod -aG docker $SUDO_USER