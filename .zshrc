# Path to your oh-my-zsh installation.
export ZSH=/home/wleese/.oh-my-zsh

export TERM="xterm-256color"
export COLORTERM="truecolor"


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
#DISABLE_AUTO_TITLE="true"

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
#plugins=(git last-working-dir compleat vagrant safe-paste)

# User configuration

export PATH="/usr/lib/go/bin:/home/wleese/perl5/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

export GIT_EDITOR=nvim
export VISUAL=nvim
export EDITOR=nvim

alias gp='git pull --rebase; git submodule sync; git submodule update --init'
alias glgg='git log -p -m'
alias glg='git log -p'
alias gc='git checkout '
alias gbm='git checkout master'
alias gbd='git checkout develop'
alias gnb='git branch'
alias gm='git merge '
alias ga='git add '
alias gai='git add -i'
alias gam='git --amend '
alias gb='git branch -va'
alias gr="git remote -v "
alias gd="git diff "
alias gs='git status'
alias v='nvim'
alias vi='nvim'
alias vim='nvim'
# alias v='vim --servername me'
# alias vi='vim --servername me'
# alias vim='vim --servername me'

function cssh () {
  for i in "$@"; do
    PARAM="${PARAM} -sc ${i}"
  done
  tmux-cssh -ts "$(date +%s)" -sc $(echo "$@" | sed 's/ / \-sc /g')
}

alias au='sudo apt-get update && sudo apt-get -uf dist-upgrade'
alias sd='sudo su -'
alias vup='vagrant up '
alias vp='vagrant provision '
alias vd='vagrant destroy -f '
alias vstat='vagrant status '
alias sshconfig="~/bin/sshconfig-create.sh > ~/.ssh/config"
alias ..='cd ..'

alias rg='grep -Rin'
alias ff="find | grep "
alias sl="ls"
alias psg="ps axf | grep "
alias resetkde='for i in plasmashell kwin_x11; do killall ${i}; sleep 1s; (nohup ${i} &) ; done'
alias h='cd ~/p/hiera'
alias m='cd ~/p/modules'
alias p='cd ~/p'

function gcm () { 
  git commit -m "$1"
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
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGESTION_HIGHLIGHT_COLOR='fg=250'

## Enable autosuggestions automatically.
#zle-line-init() {
#    zle autosuggest-start
#}
#zle -N zle-line-init

#export CDPATH=~:~/git/puppet-vagrant:~/git/puppet-vagrant/modules:~/git

function tnew { tmux new-session -As `basename $0`  }

source ~/.zshrc-company

#python virtualenvs
#export WORKON_HOME=~/.virtualenvs
#source /usr/local/bin/virtualenvwrapper.sh

export GOPATH=$HOME/golang
export PATH=$PATH:$GOPATH/bin

# alias tf='terraform'
# alias ta='terraform apply'
# alias tp='terraform plan'
# alias td='terraform destroy --force'
alias d='docker'
alias di='docker inspect'
alias dr='docker run'
alias dl='docker logs'
alias de='docker exec -ti'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias dcrm='docker kill $(docker ps -a -q); docker rm $(docker ps -a -q); docker rmi $(docker images -q)'
alias vsu='vagrant suspend'
alias vr='vagrant resume'
alias magit="vim -c MagitOnly"
function dbr {
  OUT="$(docker build . | tail -n1)"
  ID=$(echo "${OUT}" | awk '/Successfully/ {print $3}')
  if [[ $? -eq 0 ]]; then
    docker run $ID
  fi
}
function drs { docker run -ti $1 /bin/bash  }
function dk { 
  if [[ "${1}" == "" ]]; then
    docker kill $(docker ps -q)
  else
    docker kill $1
  fi
}
#
#bindkey "${terminfo[khome]}" beginning-of-line
#bindkey "${terminfo[kend]}" end-of-line
# bindkey "^[[1;5D" backward-word
# bindkey "^[[1;5C" forward-word

[ -z "$NVIM_LISTEN_ADDRESS" ] || alias :='~/bin/vv'
alias vv=": badd"

# The next line updates PATH for the Google Cloud SDK.
if [ -f /home/wleese/google-cloud-sdk/path.zsh.inc ]; then
  source '/home/wleese/google-cloud-sdk/path.zsh.inc'
fi

# The next line enables shell command completion for gcloud.
if [ -f /home/wleese/google-cloud-sdk/completion.zsh.inc ]; then
  source '/home/wleese/google-cloud-sdk/completion.zsh.inc'
fi
