# Handy Scripts
A pseduo-git repo with submodules to be installed via stow

## Install
```
mkdir -p /usr/local/stow
git clone git@github.com:arcadellama/handy-scripts /usr/local/stow/scripts
cd /usr/local/stow/scripts
git submodule update --init --recursive
```

## Update
After each git pull, be sure to run:
```
git submodule update --recursive
```
