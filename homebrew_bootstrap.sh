#!/usr/bin/env sh

homebrew_apps="
bash,bash,formula
PlexAmp,plexamp,cask
bash-completion,bash-completion,formula
shellcheck,shellcheck,formula
bitwarden-cli,bitwarden-cli,formula
stow,stow,formula
pfetch,pfetch,formula
mutt,mutt,formula
w3m,w3m,formula
isync,isync,formula
Dropbox,dropbox,cask
MacVim,macvim,cask
Firefox,homebrew/cask-versions/firefox-esr,cask
iTerm2,iterm2,cask
LibreOffice,libreoffice-still,cask
Office,microsoft-office,cask
Edge,microsoft-edge,cask
adobe-creative-cloud,adobe-creative-cloud,cask
PlexAmp,plexamp,cask
Teams,microsoft-teams,cask
tailscale,tailscale,cask
UTM,utm,cask
steam,steam,cask
BBEdit,bbedit,cask
computer-modern-font,homebrew/cask-fonts/font-computer-modern,cask
Victor-Mono-Font,font-victor-mono,cask
Chrome,google-chrome,cask
bootstrap-studio,bootstrap-studio,cask
"
brew_bin="/usr/local/bin/brew"
if [ ! -x "$brew_bin" ]; then
    printf "Install Homebrew? (Y/n): \n"
    read -r _installbrew
    case "$_installbrew" in
        N|n) exit 0 ;;
          *) printf "Installing Homebrew...\n"
             /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
             ;;
     esac
fi

if [ "$(uname)" != "Darwin" ]; then
    printf "Hey idiot, don't use this on a non-mac system.\n"
    exit 1
fi

is_running() {
    ps -p "$1" >/dev/null 2>&1
}

main() {
    if [ -z "$brew_bin" ]; then
        printf "Hey stupid, is Homebrew even installed?\n"
        exit 1
    fi
    printf "%b" "\033[s" # save cursor position
    printf "Checking for updates. "
    "$brew_bin" update --auto-update >/dev/null 2>&1 &
    bgproc="$!"
    while is_running "$bgproc"; do
        printf ". "
        sleep 1
    done
    printf "%b" "\033[2K"   # clear line
    printf "%b" "\033[u"    # restore cursor position
    old_ifs=$IFS
    while IFS=',' read -r name app type; do
        [ -n "$name" ] || continue
        printf "%b" "\033[2K"   # clear line
        printf "%b" "\033[u"    # restore cursor position
        printf "Checking %s..." "$name"
        if "$brew_bin" list "$app" >/dev/null 2>&1; then
            continue
        fi
        printf "%b" "\033[2K"   # clear line
        printf "%b" "\033[u"    # restore cursor position
        case "$type" in
             formula)  printf "Installing %s...\n" "$name"
                       "$brew_bin" install "$app"
                       ;;
                cask)  printf "Installing %s...\n" "$name"
                       "$brew_bin" install --casks "$app"
                       ;;
        esac
        printf "%b" "\033[s" # save cursor position
    done << EOF
$(printf "%s\n" "$homebrew_apps")
EOF
    IFS=$old_ifs
    printf "%b" "\033[2K"   # clear line
} 

main "$@"
