DOTFILE_TARGET = $$HOME
DOTFILE_PACKAGES = bash vim tmux linux lazygit
COC_EXTENSIONS = coc-tsserver coc-eslint coc-prettier coc-json coc-html coc-css coc-tailwindcss coc-flow coc-sh

# https://venthur.de/2021-12-19-managing-dotfiles-with-stow.html

dotfile_symlinks:
	stow --verbose --target=$(DOTFILE_TARGET) --restow $(DOTFILE_PACKAGES)

dotfile_symlinks_cleanup:
	stow --verbose --target=$(DOTFILE_TARGET) --delete $(DOTFILE_PACKAGES)

bashrc:
	touch ~/.bashrc
	[ $$(cat ~/.bashrc | grep ^"\[ -s ~/.bash_profile \] && . ~/.bash_profile"$$ | wc -l) -eq 0 ] && echo "[ -s ~/.bash_profile ] && . ~/.bash_profile" >> ~/.bashrc; exit 0

neovim:
	[ ! -d vim/.vim/plugged ] && mkdir vim/.vim/plugged; exit 0
	nvim +'PlugInstall --sync' +qa
	npm i -g yarn
	cd vim/.vim/plugged/coc.nvim; yarn; cd -;
	cd ~/.config/coc/extensions; yarn add $(COC_EXTENSIONS); cd -;

linux_fonts:
	curl "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/UbuntuMono.zip" -fLo /tmp/UbuntuMono.zip
	unzip -u /tmp/UbuntuMono.zip -d ~/.local/share/fonts
	fc-cache -fv
