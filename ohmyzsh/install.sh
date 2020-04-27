#!/bin/bash

pacman -S --needed --noconfirm zsh

chsh -s "$(which zsh)" $SUDO_USER

# Setup oh-my-zsh
ZSH=/home/$SUDO_USER/.ohmyzsh sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh) --unattended"
git clone https://github.com/zsh-users/zsh-autosuggestions /home/$SUDO_USER/.ohmyzsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /home/$SUDO_USER/.ohmyzsh/custom/plugins/zsh-syntax-highlighting