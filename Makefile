DOTFILE_TARGET = $$HOME
DOTFILE_PACKAGES = bash vim tmux linux lazygit conky
COC_EXTENSIONS = coc-tsserver coc-eslint coc-prettier coc-json coc-html coc-css coc-tailwindcss coc-flow coc-sh coc-webview coc-markdown-preview-enhanced coc-kotlin coc-explorer

linux_setup:
	sudo apt update
	make homebrew

linux_fonts:
	curl "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/UbuntuMono.zip" -fLo /tmp/UbuntuMono.zip
	sudo apt install unzip
	mkdir -p ~/.local/share/fonts
	unzip -u /tmp/UbuntuMono.zip -d ~/.local/share/fonts
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
		htop \
		|| true
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
	npm i -g mprocs

tools.linux:
	go install github.com/jesseduffield/lazynpm@latest

tools.macos:
	brew install jesseduffield/lazynpm/lazynpm

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
	bash -c "$(wget -qO- https://git.io/vQgMr)"

terminal.macos:
	bash -c "$(curl -sLo- https://git.io/vQgMr)"
