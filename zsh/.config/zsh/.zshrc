# auto completion
export ZSH="$HOME/.oh-my-zsh/"
source "$ZDOTDIR/functions/util.bash"

autoload -Uz compinit
compinit

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
alias pzf="fzf --height 100% --preview 'bat --color=always --style=full --line-range=:500 {}'"
alias open='xdg-open'

export EDITOR=nvim
export PATH=$PATH:$HOME/.cargo/bin
alias fzirob=source_robot_folders
alias nvm=source_nvm
alias ghc="source_ghcup ghc"
alias ghci="source_ghcup ghci"
alias ghcup="source_ghcup ghcup"
alias gvm="source_gvm"
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
