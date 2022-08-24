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
  file="$(find $@ -type f | pzf)"
  nvim $file
}

clang-format-all() {
  format_path="$1"
  find "$format_path" -type f \( -iname \*.h -o -iname \*.hpp -o -iname \*.cpp \) -print0 | xargs -0 clang-format -i
}

source_nvm() {
  unalias nvm
  export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
}

source_ghcup() {
  unalias ghc
  unalias ghci
  unalias ghcup
  call=$1
  shift

  [ -f "/home/max/.ghcup/env" ] && source "/home/max/.ghcup/env"
}

source_gvm() {
  unalias gvm
  source /home/max/.gvm/scripts/gvm
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

pdf-ack-grep() {
  if hash pdftotext 2>/dev/null; then
    find . -name '*.pdf' -exec sh -c 'pdftotext "{}" - | grep --with-filename --label="{}" --color '"$1" \;
  else
    echo "pdftotext not found. Please install the pdftotext utility to use this function."
  fi
}

insult() {
  echo "\033[0;31mNo, you are an idiot! Do you remember how many times you wiped your fucking drive because you didn't think about what exactly you are deleting or because you forgot a subfolder? Either THINK about what you are about to do or use trash or move, or just don't delete the fucking file(s) in the first place.\033[0m"
}
