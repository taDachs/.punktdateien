# auto completion
export ZSH="$HOME/.oh-my-zsh/"
source "$HOME/.config/zsh/functions/util.bash"

autoload -Uz compinit
compinit

# vcs info
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst

# history file
HISTFILE=~/.histfile

HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt autocd
bindkey -e

# Make colors work with tmux
# if [ ! "$TMUX" = "" ]; then export TERM=xterm-256color; fi

export ZSH_COMPDUMP=$HOME/.cache/zsh/zcompdump/.zcompdump-${SHORT_HOST}-${ZSH_VERSION}

# aliases
alias v='nvim'
alias z='zathura'
alias prettyj='python -mjson.tool'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ...='../..'
alias ....='../../..'
alias pzf='fzf --preview="less {}"'


export EDITOR=nvim
export PATH=$PATH:$HOME/.cargo/bin

source_robot_folders () {
  unalias fzirob
  source /home/max/Work/FZI/robot_folders/bin/fzirob_source.sh
  fzirob $@
}

alias fzirob=source_robot_folders

source_nvm () {
  unalias nvm
  export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
  nvm $@
}

alias nvm=source_nvm

source_ghcup () {
  unalias ghc
  unalias ghci
  unalias ghcup
  call=$1
  shift

  [ -f "/home/max/.ghcup/env" ] && source "/home/max/.ghcup/env"
  command $call $@
}

alias ghc="source_ghcup ghc"
alias ghci="source_ghcup ghci"
alias ghcup="source_ghcup ghcup"

source_gvm () {
  unalias gvm
  source /home/max/.gvm/scripts/gvm
  gvm $@
}

alias gvm="source_gvm"

setup_anymal () {
  export ROS_IP=192.168.151.69
  export ROS_MASTER_URI=http://192.168.151.51:11311
}

setup_android () {
  export ANDROID_HOME=/usr/share/android/
  export PATH=$ANDROID_HOME/cmdline-tools/tools/bin/:$PATH
  export PATH=$ANDROID_HOME/emulator/:$PATH
  export PATH=$ANDROID_HOME/platform-tools/:$PATH
}

# Promt
# enable colors
export CLICOLOR=1

# Oh my zsh
plugins=(
  poetry
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)
source $ZSH/oh-my-zsh.sh
eval "$(starship init zsh)"

# stolen from https://unix.stackexchange.com/questions/43601/how-can-i-set-my-default-shell-to-start-up-tmux
# if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  # exec tmux
# fi
