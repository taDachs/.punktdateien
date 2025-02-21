# stuff for easier handling my containers

CONTAINER_USER="ubuntu"

function crun() {
  CONTAINER="$1"
  shift 1
  if [ -z "$*" ]; then
    lxc exec "$CONTAINER" -- sudo -iu "$CONTAINER_USER" zsh
  else
    lxc exec "$CONTAINER" -- sudo -iu "$CONTAINER_USER" $@
  fi
}

function _list_containers() {
  lxc list --format csv -c n status=running
}

function _crun_complete_zsh() {
    local -a completions
    # Check the word index; 2 in zsh because zsh indexing starts from 1
    if [ $CURRENT -eq 2 ]; then
        compadd $(_list_containers)
    fi
}

function fzirobdev() {
  devcontainer up --workspace-folder $HOME/work/fzi/devcontainers/robot_folders --dotfiles-repository=https://github.com/taDachs/.punktdateien.git --dotfiles-install-command=install.bash
  devcontainer exec --workspace-folder $HOME/work/fzi/devcontainers/robot_folders zsh
}

alias devup='devcontainer up --workspace-folder . --dotfiles-repository=https://github.com/taDachs/.punktdateien.git --dotfiles-install-command=install.bash'
alias devupnodot='devcontainer up --workspace-folder .'
alias devnew='devcontainer up --workspace-folder . --dotfiles-repository=https://github.com/taDachs/.punktdateien.git --dotfiles-install-command=install.bash --remove-existing-container'
alias devrun='devcontainer exec --workspace-folder .'
alias devsh='devcontainer exec --workspace-folder . zsh'

compdef _crun_complete_zsh crun
