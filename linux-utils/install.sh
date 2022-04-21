#!/bin/bash

sudo apt install make
cd dotfiles
make homebrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Temporarily install system-level node for one-time-setup
brew install "node@16"
make bashrc tools dotfiles neovim
brew uninstall "node@16"
source ~/.bash_profile

echo 'Done! Consider running:'
echo
echo '  make linux_fonts'
