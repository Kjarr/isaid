#!/bin/bash

get_parent_dir_owner() {
    while ! [ -d $(dirname "$1") ]; do
        set $(dirname "$1")
    done

    stat -c '%U' $(dirname "$1")
}

# $1 = source dir | $2 = install dir | $3 = backup dir | [ $4 = --no-dirs ]
backup_install() {
    su -c "mkdir -p $2" - $(get_parent_dir_owner "$2")
    su -c "mkdir -p $3" - $(get_parent_dir_owner "$3")

    for f in "$1"/{,.[^.]}*; do
        f="$(basename $f)"
        # Merge dirs in the source dir with dirs in the install dir
        [[ -d "$2/$f" && "$4" != '--no-dirs' ]] && cp -an "$2/$f/." "$1/$f/"
        [[ -f "$2/$f" || ( -d "$2/$f" && "$4" != '--no-dirs' ) ]] && mv "$2/$f" "$3/"
        [[ -f "$1/$f" || ( -d "$1/$f" && "$4" != '--no-dirs' ) ]] && su -c "ln -s $1/$f $2/" - $(stat -c '%U' "$2")
    done
}

OHMYARCH="/home/$SUDO_USER/.ohmyarch"

# Backup and install dotfiles
backup_install $OHMYARCH/dotfiles $HOME $OHMYARCH/backup/dotfiles --no-dirs

# Backup and install configs
backup_install $OHMYARCH/dotfiles/.config $HOME/.config $OHMYARCH/backup/dotfiles/.config

# Backup and install local user bins
backup_install $OHMYARCH/dotfiles/.local/bin $HOME/.local/bin $OHMYARCH/backup/dotfiles/.local/bin

# Backup and install desktop application files
backup_install $OHMYARCH/dotfiles/.local/share/applications $HOME/.local/share/applications $OHMYARCH/backup/dotfiles/.local/share/applications

# Backup and install Xorg configs
backup_install $OHMYARCH/dotfiles/.config/xorg /etc/X11/xorg.conf.d $OHMYARCH/backup/dotfiles/.config/xorg

# Backup and install kernel parameters
backup_install $OHMYARCH/dotfiles/.config/sysctl /etc/sysctl.d $OHMYARCH/backup/dotfiles/.config/sysctl

# Install Arch plugin manager
su -c "ln -s $OHMYARCH/tools/apm.sh $HOME/.local/bin/apm" - $SUDO_USER