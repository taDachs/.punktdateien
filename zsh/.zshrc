export ZSH="$HOME/.oh-my-zsh/"
export DISABLE_AUTO_UPDATE=true
[ ! -d "$HOME/.cache/zsh/zcompdump" ] && mkdir -p "$HOME/.cache/zsh/zcompdump" 
export ZSH_COMPDUMP=$HOME/.cache/zsh/zcompdump/.zcompdump-${SHORT_HOST}-${ZSH_VERSION}

if [[ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]] ; then
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

if [[ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]] ; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

if [[ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zlong_alert" ]] ; then
  git clone https://github.com/kevinywlui/zlong_alert.zsh ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zlong_alert
fi

if [[ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fzf-zsh-plugin" ]] ; then
  git clone https://github.com/unixorn/fzf-zsh-plugin ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fzf-zsh-plugin
fi

if [[ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/lxd-completion-zsh" ]] ; then
  git clone https://github.com/endaaman/lxd-completion-zsh ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/lxd-completion-zsh
fi

# Oh my zsh
plugins=(
	git
	zsh-autosuggestions
	zsh-syntax-highlighting
  vi-mode
  zlong_alert
  fzf-zsh-plugin
  lxd-completion-zsh
  virtualenvwrapper
)

if [ ! -d $ZSH ]; then
  echo "Performing initial setup of oh-my-zsh"
  git clone --depth 1 https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
fi
if [ -x "$(command -v starship)" ]; then
  eval "$(starship init zsh)"
else
  ZSH_THEME=robbyrussell
fi
source $ZSH/oh-my-zsh.sh

# history file
HISTFILE=~/.histfile

HISTSIZE=100000
SAVEHIST=100000
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt autocd
bindkey -e
bindkey -M viins 'jk' vi-cmd-mode
bindkey "jk" vi-cmd-mode
bindkey "^p" history-search-backward
bindkey "^n" history-search-forward
bindkey "^Xa" _expand_alias

autoload -z edit-command-line
zle -N edit-command-line
bindkey -M vicmd " " edit-command-line


# Make colors work with tmux
# if [ ! "$TMUX" = "" ]; then export TERM=xterm-256color; fi

# Promt
# enable colors
export CLICOLOR=1

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source ~/.shellrc

if [ -x "$(command -v cowsay)" ]; then 
  cowsay "TRACK YOUR TIME"
fi
