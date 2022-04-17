export PATH=/usr/local/bin:$PATH:$HOME/go/bin:$HOME/.local/bin:$HOME/.npm/bin:$HOME/bin
export EDITOR=nvim
export GOPATH=$HOME/go
# https://github.com/feross/funding#how-can-i-disable-this
export OPEN_SOURCE_CONTRIBUTOR=true

# https://support.apple.com/en-us/HT208050
export BASH_SILENCE_DEPRECATION_WARNING=1

# Fixes an odd NPM issue in WSL/Linux:
# https://github.com/yarnpkg/yarn/issues/1016#issuecomment-283067214
export npm_config_tmp=/tmp

test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# The bash-powerline fork doesn't work well on Linux
if [ "$(uname)" == "Darwin" ]; then
  source ~/dotfiles/macos/bash-powerline/bash-powerline.sh
  source ~/dotfiles/macos/git-completion.bash
fi

# This loads Homebrew bash_completion
# https://docs.brew.sh/Shell-Completion#configuring-completions-in-bash
if type brew &>/dev/null; then
  HOMEBREW_PREFIX=$(brew --prefix)
  if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]; then
    source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
  else
    for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*; do
      [[ -r "$COMPLETION" ]] && source "$COMPLETION"
    done
  fi
fi

[ -s ~/Dropbox/bash_profile ] && source ~/Dropbox/bash_profile

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

function resource () {
  if [ -f ~/.bash_profile ]; then
    source ~/.bash_profile
  fi
  if [ -f ~/.bashrc ]; then
    source ~/.bashrc
  fi
}

# ~/.env.bash_profile is meant to be an untracked file for bespoke environment configuration
[ -s ~/.env.bash_profile ] && source ~/.env.bash_profile

alias ll="ls -lah"
alias d='lazydocker'
alias g='lazygit'
alias n='lazynpm'
alias gs='git status'

alias dot='cd ~/dotfiles'
alias oss='cd ~/oss'
alias jck='cd ~/oss/jeremyckahn'
alias D='cd ~/Desktop'
alias grep='grep --color=auto'
alias less='less -r --mouse'
alias ni="npm install --save"
alias nu="npm uninstall --save"
alias nid="npm install --save-dev"
alias nud="npm uninstall --save-dev"
alias nh="npm home"
alias ios='open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app'
alias android='~/Library/Android/sdk/emulator/emulator -avd $(~/Library/Android/sdk/emulator/emulator -list-avds | head -n 1) &'
alias nom='npm' # nom all the things

# https://iterm2.com/documentation-tmux-integration.html
# https://tmuxcheatsheet.com/
alias mux-new='tmux -CC new'
alias mux-attach='tmux -CC attach'

# Display tree of directories or previews of files
alias trees="ls -ah | fzf --preview 'if [[ -d {} ]]; then tree {}; else bat --color always {}; fi'"

# https://stackoverflow.com/a/48593067
alias list_links='npm ls --depth=0 --link=true'
alias word-diff='git diff --word-diff=color'

alias clean_ds_store='find ./ -name ".DS_Store" -depth -exec rm {} \;'

# Always follow symlinks.
#
# This alias needs to be below the RVM line above, for some crazy reason.
# Syntax errors occur on shell startup, otherwise.
alias cd="cd -P"

if [ "$(uname)" == "Linux" ]; then
  # https://stackoverflow.com/a/27456981
  alias pbcopy="xclip -selection c"
  alias pbpaste="xclip -selection c -o"
fi

# https://remysharp.com/2018/08/23/cli-improved#fzf--ctrlr
# brew install bat
function preview () {
  rg --files --hidden --glob '!.git/*' | fzf --preview 'bat --color always {}'
}

# Use FZF to preview Github gists with FZF and open them in $EDITOR.
#   Requires:
#     - https://github.com/cli/cli,
#     - https://github.com/junegunn/fzf
function gist-edit () {
  # Quoting switches between single and double quotes to leverage and avoid
  # string interpolation as necessary. There is probably a better way to do
  # this.
  gh gist edit $(
    gh gist list --limit 100 \
      | fzf --preview 'gh gist view $(echo {}'" | awk '{ print \$1 }')" \
      | awk '{ print $1 }'
  )
}

# Use FZF to preview Github issues and PRs with FZF and open them in the browser.
#   Requires:
#     - https://github.com/cli/cli,
#     - https://github.com/junegunn/fzf
#     - https://github.com/sharkdp/bat
function issues () {
  # Quoting switches between single and double quotes to leverage and avoid
  # string interpolation as necessary. There is probably a better way to do
  # this.
  gh issue view -w $(
    gh issue list --limit 100 \
      | fzf --preview 'gh issue view $(echo {}'" | awk '{ print \$1 }') | bat --color=always -l md" \
      | awk '{ print $1 }'
  )
}

function prs () {
  # Quoting switches between single and double quotes to leverage and avoid
  # string interpolation as necessary. There is probably a better way to do
  # this.
  gh pr view -w $(
    gh pr list --limit 100 \
      | fzf --preview 'gh pr view $(echo {}'" | awk '{ print \$1 }') | bat --color=always -l md" \
      | awk '{ print $1 }'
  )
}

# http://stackoverflow.com/a/21295146/470685
alias ports_in_use='lsof -i -n -P | grep TCP'

# Take whatever JSON data is in the OS X pasteboard, jsonlint it, and pipe it
# into a new Vim buffer.
#
# Requires jsonlint (`npm install -g jsonlint`).
alias json2vim='pbpaste | jsonlint | nvim -'

# Temporarily disable BASH history
# http://www.guyrutenberg.com/2011/05/10/temporary-disabling-bash-history/
alias disablehistory="unset HISTFILE"

# Prints the machine's broadcasting network IP
function ip () {
  ifconfig | grep broadcast | awk '{print $2}' | head -n1
}

function git-kill-branch () {
  # http://stackoverflow.com/a/6482403
  if [ -z "$1" ]; then
    echo "Please specify a branch."
    return 1
  fi

  git branch -D "$1"
  git push origin :"$1"
}

function git-kill-tag () {
  # https://nathanhoad.net/how-to-delete-a-remote-git-tag
  if [ -z "$1" ]; then
    echo "Please specify a tag"
    return 1
  fi

  git tag -d "$1"
  git push origin :refs/tags/"$1"
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

# Rename file "foo" to "_foo"
#
# Usage: hide [filename]
function hide () {
  if [ -z "$1" ];
  then
    echo "Please specify a file to hide."
    return
  fi

  mv $1 _$1
}

# Rename file "_foo" to "foo"
#
# Usage: unhide [filename]
function unhide () {
  if [ -z "$1" ];
  then
    echo "Please specify a file to unhide."
    return
  fi

  mv $1 ${1:1}
}

function __file_size {
  echo `cat $1 | gzip -9f | wc -c`
}

function file_size {
  echo `__file_size $1` "bytes, gzipped."
}

function minified_js_size {
  echo `__file_size <(uglifyjs $1)` "bytes, minified and gzipped."
}

function mkdir_and_follow {
  mkdir -p $1 && cd $_
}

# https://gist.github.com/meltedspork/b553985f096ab4520a2b
function killport () {
  lsof -i tcp:$1 | awk '{ if($2 != "PID") print $2}' | xargs kill -9;
}

function o () {
  if [ "$(uname)" == "Darwin" ]; then
    if [ -z "$1" ];
    then
      open ./
    else
      open $1
    fi
  else
    if [ -z "$1" ];
    then
      xdg-open ./
    else
      xdg-open $1
    fi
  fi
}

# Usage:
#
#   dl-yt-audio-chunk [youtube-url] [start-time] [duration] [filename]
#
#  start-time and duration must be in HH:MM:SS format, and filename must not
#  have a file type suffix.
#
# Requires youtube-dl and ffmpeg
function dl-yt-audio-chunk () {
  ffmpeg -ss "$2" -i $(youtube-dl -f best --get-url "$1") -t "$3" -c:v copy -c:a copy "/tmp/$4.mp4"
  ffmpeg -i "/tmp/$4.mp4" -vn -acodec copy "$4.aac"
}

# Usage:
#
#   convert-mov-to-mp4 some.mov
# https://mrcoles.com/convert-mov-mp4-ffmpeg/
function convert-mov-to-mp4 () {
  ffmpeg -i "$1" -vcodec h264 -acodec mp2 video.mp4
}

function v () {
  if [ "$(jobs | grep -c nvim)" == 0 ];
  then
    if [ -z "$1" ];
    then
      nvim
    else
      nvim "$1"
    fi
  else
    fg $(jobs | grep nvim | grep -o "\d")
  fi
}

function mirror_from_to () {
  if [ -z "$1" ] || [ -z "$2" ];
  then
    echo "Requires a \"from\" and \"to\" file"
  else
    nodemon --watch "$1" --exec "cp $1 $2"
  fi
}

function search_git_history () {
  git log --patch -U0 --color=always | less +/"$1"
}

# Use the correct Node version autimatically
# https://stackoverflow.com/a/48322289
enter_directory() {
  if [[ $PWD == $PREV_PWD ]]; then
    return
  fi

  PREV_PWD=$PWD
  [[ -f ".nvmrc" ]] && command -v nvm && nvm use
}

export PROMPT_COMMAND="enter_directory; $PROMPT_COMMAND"

# Enter the shell of a Docker container
# Thanks to @thatsnotright for this!
dexec() {
  docker exec -it $1 /bin/bash
}

dclean() {
  docker system prune --force
  docker volume prune --force
}

convert_to_demo_mp4() {
  ffmpeg -i "$1" demo.mp4
}

# For Ubuntu 20.04
restart_x() {
  sudo systemctl restart display-manager
}

# Based on https://linuxhint.com/change_swap_size_ubuntu/
change_swap_gb() {
  if [ -z $1 ];
  then
    echo "Must specify number of gigabytes"
    return
  fi

  GB="$((1024 * $1))"
  echo "Changing swap size to $GB""gb"

  sudo swapoff -a
  sudo dd if=/dev/zero of=/swapfile bs=1M count=$GB
  sudo mkswap /swapfile
  sudo swapon /swapfile

  # Show the result
  swapon -s
}

js_project_session() {
    tmux new-session -d -s ${PWD##*/} -n bash "exec bash";
    tmux new-window -d -n neovim "nvim -S Session.vim; exec bash";
    tmux new-window -d -n git "lazygit; exec bash";
    tmux new-window -d -n npm "lazynpm; exec bash";
    tmux select-window -t 1;
    tmux attach-session -d -t ${PWD##*/};
}
