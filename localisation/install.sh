#!/bin/bash

selection-menu() {
    declare -a entries=()

    IFS=$'\n'
    for line in $2; do
        entries+=("$line" "")
    done

    dialog --menu "$1" 40 60 34 --output-fd 1 "${entries[@]}"
}

selection-checklist() {
    declare -a entries=()

    IFS=$'\n'
    for line in $2; do
        entries+=("$line" "" "off")
    done

    options=$(dialog --checklist "$1" 40 60 34 --output-fd 1 "${entries[@]}")

    options=$(echo ${options//\"/})
    echo -e ${options//   /\\n}
}

# install dependencies
pacman -S --needed --noconfirm dialog

# set locales
locales=$(
    selection-checklist \
        "Select locales" \
        "$(sed -E -n '/UTF/s/^#([a-z].*)/\1/p' /etc/locale.gen)"
)

lang="$(selection-menu "Select primary locale" "$locales" | sed -E -n 's/(\S*).*/\1/p')"
language=$(echo "$lang" | sed -E -n 's/((.*)@|(.*)\.|(\S*)).*/\2\3\4/p')

echo "LANG=$lang" > /etc/locale.conf
echo "LANGUAGE=$language" >> /etc/locale.conf
echo "${locales[@]}" >> /etc/locale.gen

locale-gen