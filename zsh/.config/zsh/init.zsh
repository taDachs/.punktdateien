# auto completion
export CONFIG_DIR="$HOME/.config/zsh"
export ZSH="$HOME/.oh-my-zsh/"
source "$CONFIG_DIR/functions/util.bash"
source "$CONFIG_DIR/alias.bash"

# Oh my zsh
plugins=(
	poetry
	git
	zsh-autosuggestions
	zsh-syntax-highlighting
  vi-mode
)

source $ZSH/oh-my-zsh.sh

# history file
HISTFILE=~/.histfile

HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt autocd
bindkey -v
bindkey -M viins 'jk' vi-cmd-mode
bindkey "^p" history-search-backward
bindkey "^n" history-search-forward


# Make colors work with tmux
# if [ ! "$TMUX" = "" ]; then export TERM=xterm-256color; fi

export ZSH_COMPDUMP=$HOME/.cache/zsh/zcompdump/.zcompdump-${SHORT_HOST}-${ZSH_VERSION}

export EDITOR=nvim
export PATH=$PATH:$HOME/.cargo/bin

# Promt
# enable colors
export CLICOLOR=1

eval "$(starship init zsh)"
