# custom functions
forgit() {
  ignore_pattern="./3rdparty"
  find . -name ".git" -type d | sed 's/\/.git//' | grep -v $ignore_pattern | xargs -I{} sh -c "echo ========= {} =========; git -C {} $*;"
}

mcd() {
  mkdir -p "$1"
  cd "$1"
}

fv() {
  file="$(find $@ -type f | fzf --preview="less {}")"
  nvim $file
}

clang-format-all() {
  format_path="$1"
  find "$format_path" -type f \( -iname \*.h -o -iname \*.hpp -o -iname \*.cpp \) -print0 | xargs -0 clang-format -i
}

source_robot_folders() {
  unalias fzirob
  unalias ce
  source /home/max/Work/FZI/robot_folders/bin/fzirob_source.sh
  $@
}

source_nvm() {
  unalias nvm
  export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
  nvm $@
}

source_ghcup() {
  unalias ghc
  unalias ghci
  unalias ghcup
  call=$1
  shift

  [ -f "/home/max/.ghcup/env" ] && source "/home/max/.ghcup/env"
  command $call $@
}

source_gvm() {
  unalias gvm
  source /home/max/.gvm/scripts/gvm
  gvm $@
}

setup_anymal() {
  export ROS_IP=192.168.151.69
  export ROS_MASTER_URI=http://192.168.151.51:11311
}

setup_anymal_wifi() {
  sudo ip route add 192.168.151.0/24 via 192.168.42.151 dev wlp0s20f3
}

setup_android() {
  export ANDROID_HOME=/usr/share/android/
  export PATH=$ANDROID_HOME/cmdline-tools/tools/bin/:$PATH
  export PATH=$ANDROID_HOME/emulator/:$PATH
  export PATH=$ANDROID_HOME/platform-tools/:$PATH
}

git_sparse_clone() (
  rurl="$1" localdir="$2" && shift 2

  mkdir -p "$localdir"
  cd "$localdir"

  git init
  git remote add -f origin "$rurl"

  git config core.sparseCheckout true

  # Loops over remaining args
  for i; do
    echo "$i" >> .git/info/sparse-checkout
  done

  git pull origin master
)

git_split_off() {
  path_to_folder="$2"
  git filter-repo --subdirectory-filter "$path_to_folder"
}

get_days_until() {
  target=`date -d "$1" +%j`
  today=`date +%j`
  days=$(($target - $today))
  echo "$days"
}
