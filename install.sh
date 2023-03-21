#!/bin/bash

set -e

[ "$(uname)" == "Linux" ] && sudo apt install make
[ "$(uname)" == "Darwin" ] && xcode-select --install || true

cd ~/dotfiles
make homebrew

[ "$(uname)" == "Linux" ] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
[ "$(uname)" == "Darwin" ] && eval $(/opt/homebrew/bin/brew shellenv)

# Remove any links from a previous stow operation
[ -L ~/.profile ] && rm ~/.profile
[ -L ~/.bash_profile ] && rm ~/.bash_profile

# Keep pre-existing configuration as environment-specific files
[ -f ~/.profile ] && [ ! -f ~/.env.profile ] && mv ~/.profile ~/.env.profile
[ -f ~/.bash_profile ] && [ ! -f ~/.env.bash_profile ] && mv ~/.bash_profile ~/.env.bash_profile

make tools

[ "$(uname)" == "Linux" ] && make tools.linux
[ "$(uname)" == "Darwin" ] && make tools.macos

make bashrc dotfiles neovim

# Add -B to prevent make from bailing out due to tmux directory name
# https://stackoverflow.com/a/37489147
make -B tmux

if [ "$(uname)" == "Darwin" ]; then
  LAZYGIT_MACOS_CONFIG="$HOME/Library/Application Support/jesseduffield/lazygit"
  mkdir -p "$LAZYGIT_MACOS_CONFIG"
  ln -s "$HOME/dotfiles/lazygit/.config/lazygit/config.yml" "$LAZYGIT_MACOS_CONFIG/config.yml" || true

  brew install --cask font-ubuntu-mono-nerd-font
fi

echo 'Done! Consider running:'
echo

if [ "$(uname)" == "Darwin" ]; then
  echo '  source ~/.bash_profile'
fi

if [ "$(uname)" == "Linux" ]; then
  echo '  source ~/.bash_profile; make linux_fonts'
fi
