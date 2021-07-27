export PATH=/usr/local/bin:$PATH:$HOME/go/bin:$HOME/Library/Python/3.6/bin:$HOME/.npm/bin
export EDITOR=nvim
export GOPATH=$HOME/go
# https://github.com/feross/funding#how-can-i-disable-this
export OPEN_SOURCE_CONTRIBUTOR=true

# https://support.apple.com/en-us/HT208050
export BASH_SILENCE_DEPRECATION_WARNING=1

# Fixes an odd NPM issue in WSL/Linux:
# https://github.com/yarnpkg/yarn/issues/1016#issuecomment-283067214
export npm_config_tmp=/tmp

alias ll="ls -lah"
alias d='lazydocker'
alias g='lazygit'
alias n='lazynpm'
alias gs='git status'
alias gd='tig status'
alias gb='git branch'
alias gc='git checkout'
alias st='git stash'
alias b='tig refs'
alias c='git checkout $(git branch --all | fzf |  sed "s/remotes\/origin\///g")'
alias B='git checkout --track -b'
alias dev='git checkout develop'
alias gf='git fetch --all'
# http://stackoverflow.com/questions/6127328/how-can-i-delete-all-git-branches-which-have-been-merged
alias git-cleanup-merged-branches='git branch --merged | grep -v "\*" | xargs -n 1 git branch -d'
alias git-nuke='git reset --hard && git clean -df'
alias t='tig'

alias dot='cd ~/dotfiles'
alias oss='cd ~/oss'
alias jck='cd ~/oss/jeremyckahn'
alias D='cd ~/Desktop'
alias grep='grep --color=auto'
alias less='less -r'
alias ni="npm install --save"
alias nu="npm uninstall --save"
alias nid="npm install --save-dev"
alias nud="npm uninstall --save-dev"
alias nh="npm home"
alias nd="npm docs"
alias ios='open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app'
alias android='~/Library/Android/sdk/emulator/emulator -avd $(~/Library/Android/sdk/emulator/emulator -list-avds | head -n 1) &'
alias nom='npm' # nom all the things

# https://iterm2.com/documentation-tmux-integration.html
# https://tmuxcheatsheet.com/
alias mux-new='tmux -CC new'
alias mux-attach='tmux -CC attach'

# Display help text for user-installed binaries
alias helps="ls /usr/local/bin | fzf --preview '{} --help'"

# Display tree of directories or previews of files
alias trees="ls -ah | fzf --preview 'if [[ -d {} ]]; then tree {}; else bat --color always {}; fi'"

# https://stackoverflow.com/a/48593067
alias list_links='npm ls --depth=0 --link=true'
alias mf='misfit'
alias sudio="say There\'s this girl that\'s been on my mind All the time, Sussudio oh oh Now she don\'t even know my name But I think she likes me just the same Sussudio oh oh  Oh if she called me I\'d be there I\'d come running anywhere She\'s all I need, all my life I feel so good if I just say the word Sussudio, just say the word Oh Sussudio  Now I know that I\'m too young My love has just begun Sussudio oh oh Ooh give me a chance, give me a sign I\'ll show her anytime Sussudio oh oh  Ah, I\'ve just got to have her, have her now I\'ve got to get closer but I don\'t know how She makes me nervous and makes me scared But I feel so good if I just say the word Sussudio just say the word Oh Sussudio, oh  Ah, she\'s all I need all of my life I feel so good if I just say the word Sussudio I just say the word Oh Sussudio I just say the word Oh Sussudio I\'ll say the word Sussudio oh oh oh Just say the word"
alias word-diff='git diff --word-diff=color'
alias cs='cat $(ack -l "") | fzf'

# Similar to vim.fzf's :Rg, for VSCode
alias vf='code -g $(rg --column --line-number --no-heading --smart-case . | fzf | rg -o ".*:\d+:\d+")'
alias clean_ds_store='find ./ -name ".DS_Store" -depth -exec rm {} \;'
alias imgcat='~/dotfiles/imgcat.sh'

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

# Requires asciinema and svg-term
# brew install asciinema
# npm install -g svg-term-cli
alias record="asciinema rec /tmp/temp.cast --overwrite && cat /tmp/temp.cast | svg-term > recording.svg"

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

source ~/dotfiles/helpers/git-completion.bash
source ~/dotfiles/forgit/forgit.plugin.zsh

# Push the current branch
function PS () {
  git push origin `git branch | grep \* | sed 's/\* //'`
}

# Force push the current branch
function FORCE_PUSH () {
  git push --force-with-lease origin -u `git branch | grep \* | sed 's/\* //'`
}

# Pull the current branch
function PL () {
  git pull origin `git branch | grep \* | sed 's/\* //'`
}

# Find and replace all files recursively in the current directory.
function find_and_replace () {
  grep -rl $1 ./ | xargs sed -i s/$1/$2/
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

function resource () {
  if [ -f ~/.bash_profile ]; then
    source ~/.bash_profile
  fi
  if [ -f ~/.bashrc ]; then
    source ~/.bashrc
  fi
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

# The bash-powerline fork doesn't work well on Linux
if [ "$(uname)" == "Darwin" ]; then
  source ~/dotfiles/bash-powerline/bash-powerline.sh
fi

if [ "$(uname)" == "Linux" ]; then
  # https://stackoverflow.com/a/27456981
  alias setclip="xclip -selection c"
  alias getclip="xclip -selection c -o"
fi

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# Always follow symlinks.
#
# This alias needs to be below the RVM line above, for some crazy reason.
# Syntax errors occur on shell startup, otherwise.
alias cd="cd -P"

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

# Compare current Git branch to another brand and view it in Tig's friendly
# pager.  Usage
#
#   diffbranch develop
function diffbranch () {
  if [ -z "$1" ];
  then
    echo "You need to specify a branch."
    return
  fi

  BRANCH=$1
  git diff $BRANCH -w | tig
}

# https://gist.github.com/meltedspork/b553985f096ab4520a2b
function killport () {
  lsof -i tcp:$1 | awk '{ if($2 != "PID") print $2}' | xargs kill -9;
}

function checkpoint () {
  git commit -am "$(echo "puts Time.new.inspect" | ruby)"
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

# https://gist.github.com/intel352/9761288
function git-show-base-branch () {
  branch=`git rev-parse --abbrev-ref HEAD`
  git show-branch | ack '\*' | ack -v "$branch" | head -n1 | sed 's/.*\[\(.*\)\].*/\1/' | sed 's/[\^~].*//'
}

function _github_repo () {
  echo $(git remote -v show | head -n1 | grep -o ":.*\.git" | sed "s/^.//;s/.git//")
}

# Open the Github repo for the current directory
function GH () {
  REPO=$(_github_repo)
  open "https://github.com/$REPO"
}

function PR () {
  REPO=$(_github_repo)
  BASE_BRANCH=$(git-show-base-branch)
  CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
  open "https://github.com/$REPO/compare/$BASE_BRANCH...$CURRENT_BRANCH"
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

nr () {
  if [ -z "$1" ];
  then
    npm run $(node -e "Object.keys(require('./package.json').scripts).forEach(script => console.log(script))" | fzf)
  else
    npm run "$1"
  fi
}

function __new_project () {
  PROJECT_TYPE="$1"
  PROJECT_NAME="$2"

  if [ -z "$PROJECT_NAME" ];
  then
    echo "Must specify a project name as the first argument"
    return
  else
    git clone --depth=1 "https://github.com/jeremyckahn/$PROJECT_TYPE.git" "$PROJECT_NAME"
    cd "$PROJECT_NAME" || return
    rm -rf .git
    find . -type f -exec sed -i "" "s/$PROJECT_TYPE/$PROJECT_NAME/g" {} \;
    git init
    git add --all
    git commit -m "Initial commit"
    npm install
  fi
}

function new_cli_tool () {
  __new_project node-cli-boilerplate "$1"
}

function new_js_project() {
  __new_project js-project-starter "$1"
}

function new_react_project() {
  __new_project react-starter "$1"
}

# https://tomlankhorst.nl/brew-bundle-restore-backup/
backup_brew () {
  pushd ~/dotfiles
  brew bundle dump --force
}

#https://stackoverflow.com/a/41199625
backup_npm () {
  npm list --global --parseable --depth=0 | sed '1d' | awk '{gsub(/\/.*\//,"",$1); print}' > ~/dotfiles/npm_backup
}
restore_npm () {
  xargs npm install --global < ~/dotfiles/npm_backup
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

# Use the correct Node version autimatically
# https://stackoverflow.com/a/48322289
enter_directory() {
  if [[ $PWD == $PREV_PWD ]]; then
    return
  fi

  PREV_PWD=$PWD
  [[ -f ".nvmrc" ]] && nvm use
}

export PROMPT_COMMAND="enter_directory; $PROMPT_COMMAND"

# Enter the shell of a Docker container
# Thanks to @thatsnotright for this!
dexec() {
  docker exec -it $1 /bin/bash
}

# Pause all docker containers
# https://unix.stackexchange.com/a/17066
dpauseall() {
  for SERVICE in `docker ps | tail -n +2 | awk '{print $NF}'`; do
    docker pause $SERVICE 2> /dev/null
  done
}

dclean() {
  docker system prune --force
  docker volume prune --force
}
