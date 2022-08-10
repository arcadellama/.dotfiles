#!/usr/bin/env bash

# Colorful output
alias grep='grep --color=always'
alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'

# Docker Compose 
if [ -x /usr/bin/docker-compose ]; then
    alias dc='/usr/bin/docker-compose'
elif [ -x /usr/local/bin/docker-compose ]; then
    alias dc='/usr/local/bin/docker-compose'
else
    alias dc='docker compose'
fi

# Remove snapcraft cruft
alias lsblk='lsblk -o name,mountpoint,label,size,fstype,uuid | grep -v ^loop'
alias df='df | grep -v /dev/loop'
