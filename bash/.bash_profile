#!/usr/bin/env bash

if [ -r "$HOME/.bashrc" ]; then
    source $HOME/.bashrc
elif
    [ -r /etc/bashrc_Apple_Terminal ]; then
    source /etc/bashrc_Apple_Terminal
elif
    [ -r /etc/bashrc ]; then
    source /etc/bashrc
fi
