export PATH=/usr/local/bin:$PATH
export EDITOR=vim

# Use Vi editing mode.
#set -o vi
# Fix ctrl+l for clearing the screen in Vi mode
#bind -m vi-insert "\C-l":clear-screen

alias ll="ls -lah"
alias gs='git status'
alias gd='tig status'
alias gb='git branch'
alias gl='git log'
alias gc='git checkout'
alias gf='git fetch'
alias v='vim'
alias vr='vim -R'
alias s='cd ~/Sites'
alias l='cd ~/Sites/lib'
alias a='cd ~/Sites/app'
alias o='open ./'
alias d='cd ~/dotfiles'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias sass_watch='sass --watch style.scss:style.css'
alias tmux="tmux -2"
alias ni="node-inspector & sleep .5 && open http://0.0.0.0:8080/debug?port=5858"
# Outputs a version of a file that has no blank lines.
#   noblanklines [filename]
alias noblanklines='grep -v "^[[:space:]]*$"'

# Start a simple server.  Provide a port number as an argument or leave it
# blank to use 8080.
function serve () {
  SERVER_PORT=8080

  if [ $1 ]; then
    SERVER_PORT=$1
  fi

  python -m SimpleHTTPServer ${SERVER_PORT}
}

DOTFILES=~/dotfiles

source $DOTFILES/helpers/git-completion.bash

# Push the current directory
function psh () {
  git push origin `git branch | grep \* | sed 's/\* //'`
}

# Pull the current directory
function pll () {
  git pull origin `git branch | grep \* | sed 's/\* //'`
}

# Find and replace all files recursively in the current directory.
function find_and_replace () {
  grep -rl $1 ./ | xargs sed -i '' s/$1/$2/
}

function svnaddall () {
  svn status | grep -v "^.[ \t]*\..*" | grep "^?" | awk '{print $2}' | xargs svn add
}

# makes the connection to localhost:8888 really slow.
function goslow () {
  ipfw pipe 1 config bw 4KByte/s
  ipfw add pipe 1 tcp from any to me 8888
}

# makes the connection to localhost:8888 fast again
function gofast () {
  ipfw flush
}

# For all files in the current directory, convert tabs to 2 spaces.
function tabs_to_spaces_all () {
  for FILE in ./*; do expand -t 2 $FILE > /tmp/spaces && mv /tmp/spaces $FILE ; done;
}

function clean_dir () {
  echo "Are you really really sure?  The current directory is: "
  pwd
  read -e INPUT

  if [[ $INPUT == "y" || $INPUT == "Y" || $INPUT  == "yes" ]]; then
    echo "Removing .svn, .DS_, and ._* files... "
    find . -iname ".svn*" | xargs rm -Rv
    find . -iname ".DS_*" | xargs rm -Rv
    find . -iname "._*" | xargs rm -Rv
    echo "All done!"
  else
    echo "Cleaning of the directory was canceled."
  fi
}

function new_project () {
  mkdir src/;
  mkdir lib/;
  touch README.md;
  echo -e "*.swp\n.DS_Store" > .gitignore;
  git init;
  git add src/ lib/ .gitignore README.md;
  git commit -am "Initial commit.";
  git status;
}

function resource () {
  if [ -f ~/.bash_profile ]; then
    source ~/.bash_profile
  fi
  if [ -f ~/.bashrc ]; then
    source ~/.bashrc
  fi
}

# Colors for the command prompt
__BLUE="\[\033[0;34m\]"
__GREEN="\[\033[0;32m\]"
__LIGHT_BLUE="\[\033[1;34m\]"
__LIGHT_GRAY="\[\033[0;37m\]"
__LIGHT_GREEN="\[\033[1;32m\]"
__LIGHT_RED="\[\033[1;31m\]"
__PLAIN="\[\033[0;0m\]"
__RED="\[\033[0;31m\]"
__WHITE="\[\033[1;37m\]"

# Build a custom command prompt
function __prompt_cmd() {
  PS1="$__LIGHT_GRAY[\h]$__LIGHT_BLUE[\W]$__PLAIN "
}
export PROMPT_COMMAND=__prompt_cmd

# Setup some of the git command prompt display stuff
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILE=1
export GIT_PS1_SHOWUPSTREAM="auto"

TERM=screen-256color

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

## Raspberry Pi stuff.
# http://superpiadventures.com/2012/07/development-environment/
function rpi_mnt {
  sudo mount -t proc proc ~/rpi/chroot-raspbian-armhf/proc
  sudo mount -t sysfs sysfs ~/rpi/chroot-raspbian-armhf/sys
  sudo mount -o bind /dev ~/rpi/chroot-raspbian-armhf/dev
}

alias rpi_chroot='sudo LC_ALL=C chroot ~/rpi/chroot-raspbian-armhf'
alias rpi_start='qemu-system-arm -M versatilepb -cpu arm1176 -m 256 -hda rootfs.ext2 -kernel zImage -append "root=/dev/sda" -serial stdio &'
alias rpi_start_raspbian='qemu-system-arm -M versatilepb -cpu arm1176 -m 256 -kernel raspbian/vmlinuz-2.6.32-qemu-armv6 -initrd raspbian/initrd.img-2.6.32-qemu-armv6 -hda raspbian/raspbian.img -net nic -net user -append "root=/dev/sda1" -redir tcp:2222::22 &'
alias rpi_ssh_qemu='ssh -p2222 raspbian@localhost'

### Some craziness inserted by Eclipse.  I'll uncomment it if something breaks...
# Setting PATH for Python 2.7
# The orginal version is saved in .bash_profile.pysave
#PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
#export PATH
