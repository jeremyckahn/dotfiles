#!/bin/bash

sudo apt install make
cd dotfiles
make homebrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
make bashrc tools node dotfiles
source ~/.bashrc
make neovim

echo 'Done! Consider running:'
echo
echo '  make linux_fonts'
