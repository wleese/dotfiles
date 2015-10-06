# Path to your oh-my-zsh installation.
export ZSH=/home/wleese/.oh-my-zsh
export TERM="xterm-256color"

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
#COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git last-working-dir compleat vagrant web-search wd)

# User configuration

export PATH="/home/wleese/perl5/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

export GIT_EDITOR=vim
export VISUAL=vim
export EDITOR=vim

alias gcp='git commit -a; git push --recurse-submodules=check'
alias gp='git pull; git submodule sync; git submodule update --init'
alias glgg='git log -p -m'
alias glg='git log -p'
alias gnb='git checkout -b '
alias gpr='hub pull-request'
alias gc='git checkout '
alias gbm='git checkout master'
alias gm='git merge '
alias ga='git add '
alias gb='git branch -va'
alias gs='git status'
alias v='vim --servername me'
alias vim='vim --servername me'

function cssh () {
  for i in "$@"; do
    PARAM="${PARAM} -sc ${i}"
  done
  tmux-cssh -sc $(echo "$@" | sed 's/ / \-sc /g')
}

alias au='sudo apt-get update && sudo apt-get -uf dist-upgrade'
alias sd='sudo su -'
alias vup='vagrant up '
alias vp='vagrant provision '
alias vd='vagrant destroy -f '
alias vstat='vagrant status '
alias dcrm='docker kill $(docker ps -a -q); docker rm $(docker ps -a -q); docker rmi $(docker images -q)'
alias d='docker'
alias di='docker images'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias dl='docker ps -q -l'
alias sshconfig="~/bin/sshconfig-create.sh > ~/.ssh/config"
alias ..='cd ..'

alias rg='grep -Ri'
alias gr="git remote -v "
alias ff="find | grep "
alias sl="slock"
alias psg="ps axf | grep "
alias resetkde='for i in plasmashell kwin_x11; do killall ${i}; sleep 1s; (nohup ${i} &) ; done'

function gfd () {
  git flow feature finish $1 && git commit --amend
}

function gbd () { 
  git push origin :$1 
}

function gcm () { 
  git commit -m "$1"
}

function gca () { 
  git commit --amend -m "$1"
}

function gbr () {
  BRANCH=$(git rev-parse --abbrev-ref HEAD)
  git rebase -i master
  git branch -m $BRANCH "${BRANCH}_ready"
  git push origin "${BRANCH}_ready"
  git push origin ":${BRANCH}"
}

function lsv() {
  grep "^${1}" ~/Documents/servers.txt | tr '\n' ' '
}

function vs (){
  vagrant ssh $1 -- -At  "echo \"$(cat ~/nicealiases)\" > /tmp/nicealiases; echo \"$(cat ~/nicevimrc)\" > /tmp/nicevimrc; bash --rcfile /tmp/nicealiases "
}

function s (){
  ssh -At $1 "echo \"$(cat ~/nicealiases)\" > /tmp/nicealiases; echo \"$(cat ~/nicevimrc)\" > /tmp/nicevimrc; bash --rcfile /tmp/nicealiases "
}
 
# show completion menu when number of options is at least 2
#zstyle ':completion:*' menu select=4

zstyle -s ':completion:*:hosts' hosts _ssh_config
[[ -r ~/Documents/servers.txt ]] && _ssh_config+=($(cat ~/Documents/servers.txt))
zstyle ':completion:*:hosts' hosts $_ssh_config
compdef s=ssh

source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
source ~/.zsh/zsh-autosuggestions/autosuggestions.zsh
AUTOSUGGESTION_HIGHLIGHT_COLOR='fg=250'

# Enable autosuggestions automatically.
zle-line-init() {
    zle autosuggest-start
}
zle -N zle-line-init
 
export CDPATH=~:~/git/puppet-vagrant:~/git/puppet-vagrant/modules:~/git

function tnew { tmux new-session -As `basename $0`  }

source .zshrc-company
