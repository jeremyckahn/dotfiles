DOTFILE_TARGET = $$HOME
DOTFILE_PACKAGES = bash vim tmux linux lazygit btop gh-dash
COC_EXTENSIONS = coc-tsserver coc-eslint coc-prettier coc-json coc-html coc-css coc-tailwindcss coc-flow coc-sh coc-webview coc-markdown-preview-enhanced coc-kotlin coc-explorer coc-marketplace coc-react-refactor coc-yaml coc-git coc-pyright coc-clangd coc-docker coc-prisma coc-spell-checker

linux_setup:
	sudo apt update
	make homebrew

linux_fonts:
	curl "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/Hack.zip" -fLo /tmp/Hack.zip
	sudo apt install unzip
	mkdir -p ~/.local/share/fonts
	unzip -u /tmp/Hack.zip -d ~/.local/share/fonts
	fc-cache -fv

macos_setup:
	make homebrew
	git submodule init
	git submodule update

bashrc:
	touch ~/.bashrc
	[ $$(cat ~/.bashrc | grep ^"\[ -s ~/.bash_profile \] && . ~/.bash_profile"$$ | wc -l) -eq 0 ] && echo "[ -s ~/.bash_profile ] && . ~/.bash_profile" >> ~/.bashrc; exit 0

homebrew:
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# https://venthur.de/2021-12-19-managing-dotfiles-with-stow.html
dotfiles:
	stow --verbose --target=$(DOTFILE_TARGET) --restow $(DOTFILE_PACKAGES)

dotfiles_cleanup:
	stow --verbose --target=$(DOTFILE_TARGET) --delete $(DOTFILE_PACKAGES)

tools:
	# || true is appended to prevent spurious brew errors from ending this build
	# step prematurely
	brew install \
		stow \
		go \
		lazygit \
		lazydocker \
		tmux \
		ripgrep \
		bat \
		git-delta \
		gh \
		node \
		btop \
		htop \
		|| true
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
	npm i -g mprocs
	gh extension install dlvhdr/gh-dash

tools.linux:
	sudo apt install gawk net-tools coreutils wl-clipboard


tools.macos:
	brew install gawk coreutils

neovim:
	brew install neovim
	[ ! -d vim/.vim/plugged ] && mkdir vim/.vim/plugged; exit 0
	nvim +'PlugInstall --sync' +qa
	npm i -g yarn
	cd vim/.vim/plugged/coc.nvim; yarn; cd -;
	cd ~/.config/coc/extensions; yarn add $(COC_EXTENSIONS); cd -;

tmux:
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# https://github.com/Gogh-Co/Gogh
terminal.linux:
	wget -qO- https://git.io/vQgMr | bash

terminal.macos:
	curl -sLo- https://git.io/vQgMr | bash
