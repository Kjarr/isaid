#!/bin/bash

selection-menu() {
    declare -a entries=()

    while read line; do
        entries+=("$line" "" "off")
    done < <($2)

    options=$(dialog --checklist "$1" 40 60 34 --output-fd 1 "${entries[@]}")

    echo ${options// /,}
}

# install dependencies
pacman -S --needed --noconfirm dialog

# set keymap
layouts=$(selection-menu "Select keyboard layouts" "localectl list-x11-keymap-layouts")
model=$(selection-menu "Select keyboard model" "localectl list-x11-keymap-models")
variant=$(selection-menu "Select keyboard variant" "localectl list-x11-keymap-variants $layout")
options=$(selection-menu "Select keyboard options" "localectl list-x11-keymap-options")

localectl set-x11-keymap "$layouts" "$model" "$variant" "$options"