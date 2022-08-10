#!/usr/bin/env bash

# Local path environment
export PATH="/usr/local/sbin:/usr/sbin:/sbin:$PATH"
export PATH="$PATH:$HOME/.local/bin"

# Import Bitwarden CLI Session Key
if [ -r $HOME/.bw-session ]; then
    . $HOME/.bw-session
fi

# macOS Environment
if [ "$(uname)" == "Darwin" ]; then

    # Check for iterm integration
    test -e ~/.iterm2_shell_integration.bash && \
        source ~/.iterm2_shell_integration.bash || true

    case $(uname -p) in
        arm*)
            # Export Homebrew for Apple Silicon
            export PATH=/opt/homebrew/bin:/opt/homebrew/sbin:$PATH
            ;;
        *)
            # Bash Completion
            if [ -r /usr/local/etc/profile.d/bash_completion.sh ]; then
                source /usr/local/etc/profile.d/bash_completion.sh
            fi
            ;;
    esac
    
else
    if [ "$(shopt login_shell | awk '{print $2}')" == "off" ]; then 
            if [ -e /etc/profile ]; then
                    source /etc/profile
            fi
    fi
fi

# Source Aliases
if [ -r $HOME/.bash_aliases ]; then
        source $HOME/.bash_aliases
fi

#export TERM=xterm-256color
export EDITOR=vim
export PAGER=less

# Gentoo-style prompt
color_prompt=yes
export LSCOLORS="ExGxFxdxCxDxDxhbadExEx"
PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] '


# VIM settings
if [ ! -d $HOME/.vim/backup ]; then
    mkdir -p $HOME/.vim/backup
fi

if [ ! -d $HOME/.vim/undo ]; then
    mkdir -p $HOME/.vim/undo
fi

# Check if interactive prompt
if [[ $- == *i* ]]; then 
    # Fancy login-prompt
    if [ -x $HOME/.local/bin/arcade-greeting ]; then
        $HOME/.local/bin/arcade-greeting
    fi

    # Plex Status
    if [ -x "$(command -v lolcat)" ]; then
        __out="lolcat"
    else
        __out="tee"
    fi

    if [ -x /usr/local/bin/nowplaying ]; then
            /usr/local/bin/nowplaying \
                -p "192.168.111.1 10.0.1.111" -w 100 | "$__out"
            printf "\n"
    fi
fi

