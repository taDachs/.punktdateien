if [ ! -d "/opt/ros/humble"  ] \
  && [ ! -d "/opt/ros/iron" ] \
  && [ ! -d "/opt/ros/foxy" ] \
  && [ ! -d "/opt/ros/rolling" ] \
  ; then
  return 0
fi

if [ -f /usr/share/colcon_cd/function/colcon_cd.sh ]; then
  source /usr/share/colcon_cd/function/colcon_cd.sh
fi

eval "$(register-python-argcomplete3 ros2)"
eval "$(register-python-argcomplete3 colcon)"

_check_colcon_prefix_path() {
  if [ -z "$COLCON_PREFIX_PATH" ]; then
    echo "Error: COLCON_PREFIX_PATH is not set. Make sure you have sourced the ROS 2 setup file."
    return 1
  fi

  if [ ! -d "$COLCON_PREFIX_PATH" ]; then
    echo "Error: COLCON_PREFIX_PATH directory does not exist."
    return 1
  fi
  return 0
}

_list_packages() {
  _check_colcon_prefix_path || return 1
  colcon list --names-only --base-paths="$(dirname "$COLCON_PREFIX_PATH")"
}

_list_package_files() {
  local package_path="$(colcon info "$package_name" | grep -P '(?<=path: )(.*)' -o)"
  find "$package_path" -type f -exec basename {} \;
}

ros2ed() {
  if [ "$#" -ne 2 ]; then
    echo "Usage: ros2ed <package_name> <file_name>"
    return 1
  fi

  local package="$1"
  local file="$2"

  _check_colcon_prefix_path || return 1

  colcon edit --base-paths="$(dirname "$COLCON_PREFIX_PATH")" "$package" "$file"
}

_ros2ed_completion() {
  local cur prev
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD-1]}"
  
  # Complete package names using _list_packages function
  if [[ $COMP_CWORD -eq 1 ]]; then
    COMPREPLY=($(compgen -W "$(_list_packages)" -- "$cur"))
    return 0
  fi

  # Complete file names using _list_package_files function
  if [[ $COMP_CWORD -eq 2 ]]; then
    local package_name="${COMP_WORDS[1]}"
    COMPREPLY=($(compgen -W "$(_list_package_files "$package_name")" -- "$cur"))
    return 0
  fi
}
complete -F _ros2ed_completion ros2ed

ros2cd() {
  if [ -v OLDPWD ]; then
    _check_colcon_prefix_path || return 1
    cd "$(dirname "$COLCON_PREFIX_PATH")"
    colcon_cd --set > /dev/null
  fi
  if [ "$#" -eq 0 ]; then
    colcon_cd
  elif [ "$#" -eq 1 ]; then
    local package="$1"
    colcon_cd "$package"
  else
    echo "Usage: ros2cd [package_name]"
    return 1
  fi
}

_ros2cd_completion() {
  local cur
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  
  # Complete package names using _list_packages function
  COMPREPLY=($(compgen -W "$(_list_packages)" -- "$cur"))
}
complete -F _ros2cd_completion ros2cd

_fzf_complete_ros2cd() {
  _fzf_complete "--sort" "$@" < <(_list_packages)
}
[ -n "$BASH" ] && complete -F _fzf_complete_colcon -o default -o bashdefault colcon

_fzf_complete_ros2ed() {
  read -r -A args <<< "$@"
  num="${#args[@]}"
  if [ $num -eq 2 ]; then
    _fzf_complete "--sort" "$@" < <(_list_packages)
  elif [ $num -eq 3 ]; then
    local package_name="${args[2]}"
    local package_path="$(colcon info "$package_name" | grep -P '(?<=path: )(.*)' -o)"
    _fzf_complete "--sort" "$@" < <(_list_package_files "$package_path")
  fi
}

_fzf_complete_ros2() {
  read -r -A args <<< "$@"
  local verb="${args[2]}"
  if [ "$verb" = "interface" ]; then
    ros2 interface list | cat | grep -P -o '(?<=\s{2})\S+$' | _fzf_complete "--sort" "$@"
  else
    ros2 $verb list | _fzf_complete "--sort" "$@"
  fi
}
[ -n "$BASH" ] && complete -F _fzf_complete_ros2 -o default -o bashdefault ros2

alias ros2build="colcon build --cmake-args -DCMAKE_EXPORT_COMPILE_COMMANDS=1 --symlink-install"
alias ros2test="colcon test --ctest-args --event-handlers console_cohesion+"
