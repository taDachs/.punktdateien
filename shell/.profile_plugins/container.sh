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

compdef _crun_complete_zsh crun
