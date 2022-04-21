#!/bin/bash

set -e

sudo apt install make
cd ~/dotfiles
make homebrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

make dotfiles_cleanup

[ -f ~/.profile ] && [ ! -f ~/.env.profile ] && mv ~/.profile ~/.env.profile
[ -f ~/.bash_profile ] && [ ! -f ~/.env.bash_profile ] && mv ~/.bash_profile ~/.env.bash_profile

make bashrc tools dotfiles neovim

echo 'Done! Consider running:'
echo
echo '  source ~/.bash_profile; make linux_fonts'
