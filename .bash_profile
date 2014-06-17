export PATH=/usr/local/bin:$PATH
export EDITOR=vim

alias ll="ls -lah"
alias gs='git status'
alias gd='tig status'
alias gb='git branch'
alias gl='git log'
alias gc='git checkout'
alias gf='git fetch'
alias git-nuke='git reset --hard && git clean -f'
alias ss='svn status'
alias v='vim'
alias t='tig'
alias vr='vim -R'
alias s='cd ~/Sites'
alias l='cd ~/Sites/lib'
alias a='cd ~/Sites/app'
alias o='open ./'
alias d='cd ~/dotfiles'
alias grep='grep --color=auto'
alias sass_watch='sass --watch style.scss:style.css'
alias tmux="tmux -2"
alias ni="open http://127.0.0.1:8080/debug?port=5858 && node-inspector"
# Outputs a version of a file that has no blank lines.
#   noblanklines [filename]
alias noblanklines='grep -v "^[[:space:]]*$"'

# `u N` will `cd` up N directories.
# Thanks to James Johnson for this.
u() {
  local ts=$(printf "%${1}s");
  cd $(printf %s "${ts// /../}");
}

# Start a simple server.  Provide a port number as an argument or leave it
# blank to use 8080.
#
# Requires Node and http-server:
#   npm install http-server -g
function serve () {
  SERVER_PORT=8080

  if [ $1 ]; then
    SERVER_PORT=$1
  fi

  http-server ./ -p ${SERVER_PORT}
}

# Prints the machine's broadcasting network IP
function ip () {
  ifconfig | grep broadcast | awk '{print $2}'
}

# Use node-inspector to debug Grunt.  To use this:
#
#   1. Fire up node-inspector (it's aliased above as `ni`), leave it running
#   2. In another shell, call grunt-debug [task]
#
# Example:
#
#  grunt-debug server
#
# Adapted from http://stackoverflow.com/a/12739260
function grunt-debug () {
  node --debug-brk $(which grunt) $1
}

# Starts watching a file and `cat`s it whenever the contents change. Ctrl+c to
# quit.
#
# Requires Node and nodemon:
#   npm install -g nodemon
function watch_and_log () {
  nodemon -x cat $1 -w $1
}

# OS X only.  Serve a directory and open the default browser to it.
function open_and_serve () {
  SERVER_PORT=8080

  if [ $1 ]; then
    SERVER_PORT=$1
  fi

  open http://localhost:${SERVER_PORT}; serve ${SERVER_PORT}
}

function git-kill-branch () {

  # http://stackoverflow.com/a/6482403
  if [ -z "$1" ]; then
    echo "Please specify a branch."
    return 1
  fi

  git branch -D $1
  git push origin :$1
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
  grep -rl $1 ./ | xargs sed -i s/$1/$2/
}

function svnaddall () {
  svn status | grep -v "^.[ \t]*\..*" | grep "^?" | awk '{print $2}' | xargs svn add
}

function svndeleteall () {
  svn status | grep -v "^.[ \t]*\..*" | grep '^!' | awk '{print $2}' | xargs svn rm
}

# Usage:
#
#   svndiff
#
# With no arguments, show the diff of the current set of uncommitted changes.
#
#   svndiff [revision_number]
#
# Provide a revision number to see a diff of that commit.
function svndiff () {
  if [ -z "$1" ];
  then
    svn diff | tig
  else
    svn diff -c $1 | tig
  fi
}
alias sd='svndiff'

# This hacky thing comes from: http://stackoverflow.com/q/10699184
function svnrevertpattern () {
  if [ -z "$1" ];
  then
    echo "You need to specify a pattern."
  else
    svn revert `svn status .|grep "$1"|awk '{print $2}'`
  fi
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

# Fixes newline copy issues in some web apps I use
function convert_pbpaste_to_double_newlines () {
  pbpaste | sed 's/^$/\'$'\n/g' | pbcopy
}

# Take an AAC audio file and convert to all formats needed for the web.
# Requires FFmpeg with Vorbis support:
#
#   brew install ffmpeg --with-libvorbis
#
# Usage:
#
#   webify_aac some.aac
function webify_aac () {
  if [ -z "$1" ];
  then
    echo "You need to specify a file."
    exit 1
  fi

  # http://stackoverflow.com/a/125340
  filename=${1%.*}
  ffmpeg -i $1 $filename.ogg
  ffmpeg -i $1 $filename.mp3
}

# Compare the contents of a directory tree, recursively.
#
# Usage:
#
#  compare_trees dir_one dir_two
function compare_trees () {
  if [ -z "$1" -o -z "$2" ];
  then
    echo "You need to specify two directories to compare."
    exit 1
  fi

  diff <(pushd $1; ls -R) <(pushd $2; ls -R)
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

# Names iTerm2 tab
# http://superuser.com/a/560393
function name_tab () {
  if [ $1 ]; then
    TAB_NAME=$1
  else
    # Get the current directory name if no tab name was specified
    # http://stackoverflow.com/a/1371283
    TAB_NAME=${PWD##*/}
  fi

  str='echo -ne "\033]0;'$TAB_NAME'\007"'
  export PROMPT_COMMAND=$str
  echo "iTerm tab is now \"$TAB_NAME\""
}

# Setup some of the git command prompt display stuff
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILE=1
export GIT_PS1_SHOWUPSTREAM="auto"

TERM=screen-256color

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# Always follow symlinks.
#
# This alias needs to be below the RVM line above, for some crazy reason.
# Syntax errors occur on shell startup, otherwise.
alias cd="cd -P"

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
