# DOTFILE_TARGET = $$HOME
DOTFILE_TARGET = /tmp/dotfile-target
DOTFILE_PACKAGES = vim tmux linux lazygit

dotfile_symlinks:
	stow --verbose --target=$(DOTFILE_TARGET) --restow $(DOTFILE_PACKAGES)

dotfile_symlinks_cleanup:
	stow --verbose --target=$(DOTFILE_TARGET) --delete $(DOTFILE_PACKAGES)
