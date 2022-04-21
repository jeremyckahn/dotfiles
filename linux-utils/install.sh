#!/bin/bash

set -e

sudo apt install make
cd ~/dotfiles
make homebrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Remove any links from a previous stow operation
[ -L ~/.profile ] && rm ~/.profile
[ -L ~/.bash_profile ] && rm ~/.bash_profile

# Keep pre-existing configuration as environment-specific files
[ -f ~/.profile ] && [ ! -f ~/.env.profile ] && mv ~/.profile ~/.env.profile
[ -f ~/.bash_profile ] && [ ! -f ~/.env.bash_profile ] && mv ~/.bash_profile ~/.env.bash_profile

make tools bashrc dotfiles neovim

echo 'Done! Consider running:'
echo
echo '  source ~/.bash_profile; make linux_fonts'
