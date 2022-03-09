# auto completion
source "$HOME/.config/zsh/profiles/completion.zsh"
source "$HOME/.config/zsh/external/git_prompt.sh"
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

# Plugins
source "$HOME/.local/share/miniplug.zsh"

miniplug plugin 'zsh-users/zsh-syntax-highlighting'
miniplug plugin 'zsh-users/zsh-history-substring-search'
miniplug plugin 'zsh-users/zsh-completions'
miniplug load

export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND="bg=magenta,fg=white,bold"
export ZSH_COMPDUMP=$HOME/.cache/zsh/zcompdump/.zcompdump-${SHORT_HOST}-${ZSH_VERSION}

# Keybind
bindkey "$key[Up]" history-substring-search-up
bindkey "$key[Down]" history-substring-search-down
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word

# aliases
alias v='nvim'
alias z='zathura'
alias prettyj='python -mjson.tool'
alias fv='f(){ find $@ | fzf | xargs nvim }; f'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ...='../..'
alias ....='../../..'
alias paramdoc-ros='python3 ~/Work/FZI/projects/auto_doc/paramdoc_ros.py'

# robot_folders setup
source /home/max/Work/FZI/robot_folders/bin/fzirob_source.sh

export EDITOR=nvim
export PATH=$PATH:$HOME/.cargo/bin
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Promt
# enable colors
export CLICOLOR=1

# git prompt things
GIT_PS1_SHOWCOLORHINTS=1
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM="auto"

PROMPT_TIME='[%F{yellow}%*%f]'
PROMPT_HOSTNAME='%B%n%b%B@%b%B%m%b'
PROMPT_CWD='%F{blue}%~%f'
PROMPT_END='%F{%(?.green.red)} ▶%f '
PROMPT='$PROMPT_TIME:$PROMPT_HOSTNAME:$PROMPT_CWD$(__git_ps1 " (%s)")$PROMPT_END'
RPROMPT_RETURN_CODE='%F{red}%(?..return %?)%f'
RPROMPT='$RPROMPT_RETURN_CODE'
fpath+=~/.zsh/zsh_functions

# [ -f "/home/max/.ghcup/env" ] && source "/home/max/.ghcup/env"
