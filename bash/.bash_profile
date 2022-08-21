#!/usr/bin/env bash

case "$(uname -s)" in
    Darwin)
        export BASH_SILENCE_DEPRECATION_WARNING=1
        if [ ! -e "$HOME/.hushlogin" ]; then
        touch "$HOME/.hushlogin"
        fi
        ;;
esac

if [ -r "$HOME/.bashrc" ]; then
    source $HOME/.bashrc
elif
    [ -r /etc/bashrc_Apple_Terminal ]; then
    source /etc/bashrc_Apple_Terminal
elif
    [ -r /etc/bashrc ]; then
    source /etc/bashrc
fi
