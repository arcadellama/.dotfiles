#!/usr/bin/env sh

script="$1"
exec_command=""
hashbang=$(head -n 1 "$script")

case "$hashbang" in \#\!*) printf "%s\n" "${hashbang#\#\!}" ;; esac
