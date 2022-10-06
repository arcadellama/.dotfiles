#!/usr/bin/env sh

homebrew_apps="
bash,bash,formula
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
Teams,microsoft-teams,cask
computer-modern-font,homebrew/cask-fonts/font-computer-modern,cask
Victor-Mono-Font,font-victor-mono,cask
tailscale,tailscale,cask
UTM,utm,cask
steam,steam,cask
"

if [ -x /usr/local/bin/brew ]; then
    brew_bin="/usr/local/bin/brew"
fi

if [ "$(uname)" != "Darwin" ]; then
    printf "Hey idiot, don't use this on a non-mac system.\n"
    exit 1
fi

main() {
    if [ -z "$brew_bin" ]; then
        printf "Hey stupid, is Homebrew even installed?\n"
        exit 1
    fi
    "$brew_bin" update --auto-update
    old_ifs=$IFS
    while IFS=',' read -r name app type; do
        [ -n "$name" ] || continue
         if "$brew_bin" list "$app" >/dev/null 2>&1; then
             continue
         fi
         case "$type" in
             formula)  printf "Installing %s...\n" "$name"
                       "$brew_bin" install "$app"
                       shift 3 ;;
                cask)  printf "Installing %s...\n" "$name"
                       "$brew_bin" install --casks "$app"
                       shift 3 ;;
                   *)  printf "Error, %s isn't properly formatted.\n" \
                       "$type" ;;
         esac
    done << EOF
$(printf "%s\n" "$homebrew_apps")
EOF
    IFS=$old_ifs
} 

main "$@"
