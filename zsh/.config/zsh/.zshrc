# auto completion
source $HOME/.config/zsh/profiles/completion.zsh
source $HOME/.config/zsh/external/git_prompt.sh

autoload -Uz compinit
compinit

# vcs info
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst

# history file
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
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

# custom functions
forgit() {
    ignore_pattern="./3rdparty"
    find . -name ".git" -type d | sed 's/\/.git//' | grep -v $ignore_pattern |  xargs -I{} sh -c "echo ========= {} =========; git -C {} $*;"
}

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

[ -f "/home/max/.ghcup/env" ] && source "/home/max/.ghcup/env"
