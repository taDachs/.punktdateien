#  ____   ___  ____  
# |  _ \ / _ \/ ___| 
# | |_) | | | \___ \ 
# |  _ <| |_| |___) |
# |_| \_\\___/|____/ 


#   ____ ___  __  __ ____  _     _____ _____ ___ ___  _   _ 
#  / ___/ _ \|  \/  |  _ \| |   | ____|_   _|_ _/ _ \| \ | |
# | |  | | | | |\/| | |_) | |   |  _|   | |  | | | | |  \| |
# | |__| |_| | |  | |  __/| |___| |___  | |  | | |_| | |\  |
#  \____\___/|_|  |_|_|   |_____|_____| |_| |___\___/|_| \_|

# Stolen from https://github.com/fmauch/dot_profile/blob/master/.profile_plugins/fzf_completions.sh
_fzf_complete_rostopic() {
  _fzf_complete "--sort" "$@" < <(
    rostopic list
  )
}
[ -n "$BASH" ] && complete -F _fzf_complete_rostopic -o default -o bashdefault rostopic

_fzf_complete_rosnode() {
  _fzf_complete "--sort" "$@" < <(
    rosnode list
  )
}
[ -n "$BASH" ] && complete -F _fzf_complete_rosnode -o default -o bashdefault rosnode

_fzf_complete_rosservice() {
  _fzf_complete "--sort" "$@" < <(
    rosservice list
  )
}
[ -n "$BASH" ] && complete -F _fzf_complete_rosservice -o default -o bashdefault rosservice

_fzf_complete_rosparam() {
  _fzf_complete "--sort" "$@" < <(
    rosparam list
  )
}
[ -n "$BASH" ] && complete -F _fzf_complete_rosparam -o default -o bashdefault rosparam

_fzf_complete_roslaunch() {
  _fzf_complete "--sort" "$@" < <(
    rospack list-names
  )
}
[ -n "$BASH" ] && complete -F _fzf_complete_roslaunch -o default -o bashdefault roslaunch

_fzf_complete_rosrun() {
  _fzf_complete "--sort" "$@" < <(
    rospack list-names
  )
}
[ -n "$BASH" ] && complete -F _fzf_complete_rosrun -o default -o bashdefault rosrun

_fzf_complete_rossrv() {
  _fzf_complete "--sort" "$@" < <(
    rossrv list
  )
}
[ -n "$BASH" ] && complete -F _fzf_complete_rossrv -o default -o bashdefault rossrv

_fzf_complete_rosmsg() {
  _fzf_complete "--sort" "$@" < <(
    rosmsg list
  )
}
[ -n "$BASH" ] && complete -F _fzf_complete_rosmsg -o default -o bashdefault rosmsg

_fzf_complete_roscd() {
  _fzf_complete "--sort" "$@" < <(
    rospack list-names
  )
}
[ -n "$BASH" ] && complete -F _fzf_complete_roscd -o default -o bashdefault roscd


#  _____ _   _ _   _  ____ _____ ___ ___  _   _ ____  
# |  ___| | | | \ | |/ ___|_   _|_ _/ _ \| \ | / ___| 
# | |_  | | | |  \| | |     | |  | | | | |  \| \___ \ 
# |  _| | |_| | |\  | |___  | |  | | |_| | |\  |___) |
# |_|    \___/|_| \_|\____| |_| |___\___/|_| \_|____/ 

# for lazy loading fzirob
source_robot_folders() {
  unalias fzirob
  unalias ce
  echo "source ${HOME}/.local/pipx/venvs/robot-folders/bin/rob_folders_source.sh"
  $@
}


clang-format-all() {
  format_path="$1"
  find "$format_path" -type f \( -iname \*.h -o -iname \*.hpp -o -iname \*.cpp \) -print0 | xargs -0 clang-format -i
}

#      _    _     ___    _    ____  _____ ____  
#     / \  | |   |_ _|  / \  / ___|| ____/ ___| 
#    / _ \ | |    | |  / _ \ \___ \|  _| \___ \ 
#   / ___ \| |___ | | / ___ \ ___) | |___ ___) |
#  /_/   \_\_____|___/_/   \_\____/|_____|____/ 

alias roscdd='roscd && cd ..'

alias fzirob="source_robot_folders fzirob"
alias ce="source_robot_folders fzirob change_environment"
alias catmux="tmux -L catmux"
