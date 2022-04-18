# Dotfiles

These are the dotfiles that I use and live by.  Perhaps you will find them useful too!

To set up Linux (this is still a work in progress):

```sh
sudo apt install make stow
git clone https://github.com/jeremyckahn/dotfiles.git
cd dotfiles
make homebrew
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.profile
make bashrc tools
```

Then, in a new shell instance:

```sh
mv ~/.profile ~/.profile.bak
cd dotfiles
make dotfiles neovim
```
