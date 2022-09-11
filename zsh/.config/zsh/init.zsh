source ~/.shellrc

export CONFIG_DIR="$HOME/.config/zsh"
export ZSH="$HOME/.oh-my-zsh/"

# i am an idiot
function trash () {( set -e
  mkdir -p /tmp/trash
  force=false
  recursive=false

  while getopts "fr" opt; do
    case $opt in
      f)
        force=true
        ;;
      r)
        recursive=true
        ;;
      *)
        exit 1;
    esac
  done
  shift $((OPTIND - 1))

  for var in "$@"; do
    exists=false
    if [[ -f "$var" || -d "$var" ]]; then
      exists=true
    fi
    if [[ "$exists" = true || "$force" = true ]]; then
      if [[ (-d "$var") && ("$recursive" = false) ]]; then
        echo "trash: cannot trash $var: $var is a directory"
        exit 1
      fi
    else
        echo "trash: cannot trash $var: No such file or directory"
        exit 1
    fi
  done
  for var in "$@"; do
    if [[ -f "$var" || -d "$var" ]]; then
      \rm -rf /tmp/trash/$var
      mv -f "$var" /tmp/trash
    fi
  done
)}

alias rm="trash"

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

# Promt
# enable colors
export CLICOLOR=1

eval "$(starship init zsh)"
# source /usr/share/doc/fzf/examples/key-bindings.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
