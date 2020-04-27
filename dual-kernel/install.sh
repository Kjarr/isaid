#!/bin/bash

# pacman -S --needed --noconfirm linux-lts

fnc=\
'update() {
    # TODO: use uname for checking asd & qwe
    if grep -q "lts" /boot/loader/loader.conf; then
        sudo pacman -Syyu --ignore linux,linux-headers
    else
        sudo pacman -Syyu --ignore linux-lts,linux-lts-headers
    fi
}'

fnc_name=$(echo "$fnc" | sed -E -n 's/(.*)\(\).*/\1/p')
fnc_one_line=$(echo "$fnc" | sed ':a;N;$!ba;s/\n/\\n/g')
fnc_one_line_escaped=$(sed -e 's/[&\\/]/\\&/g' -e '$s/\\$//' <<<"$fnc_one_line")
sed -n -i.bak '1!H;1h;${x;s^'"$fnc_name"'() {[^}]*}^'"$fnc_one_line_escaped"'^;s/\\n/\n/g;p}' ~/.shrc