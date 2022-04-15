DOTFILE_TARGET = $$HOME
DOTFILE_PACKAGES = bash vim tmux linux lazygit

# https://venthur.de/2021-12-19-managing-dotfiles-with-stow.html

dotfile_symlinks:
	stow --verbose --target=$(DOTFILE_TARGET) --restow $(DOTFILE_PACKAGES)

dotfile_symlinks_cleanup:
	stow --verbose --target=$(DOTFILE_TARGET) --delete $(DOTFILE_PACKAGES)
