#!/usr/bin/env sh
apt_bin="/usr/bin/apt"
_packages="bash vim git sudo stow screen"

if [ -x "$apt_bin" ]; then
    "$apt_bin" update
    "$apt_bin" install -y ${_packages}
else
    printf "Error: %s not installed.\n" "$apt_bin"
fi
