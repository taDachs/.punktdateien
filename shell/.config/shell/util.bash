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
  export ANDROID_HOME=$HOME/.local/share/android
  export PATH=$ANDROID_HOME/cmdline-tools/latest/bin:$PATH
  export PATH=$ANDROID_HOME/tools/bin:$PATH
  export PATH=$ANDROID_HOME/emulator:$PATH
  export PATH=$ANDROID_HOME/platform-tools:$PATH
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
  path_to_folder="$1"
  git filter-repo --force --subdirectory-filter "$path_to_folder"
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

start_tmux_ba_session() {
  session_name="Bachelorthesis"

  # Only create tmux session if it doesn't already exist
  if ! tmux has-session -t $session_name; then
    cd /home/max/current_semester/bachelorarbeit/
    # Start New Session with our name
    tmux new-session -d -s $session_name -n 'Document'

    # open bachelorthesis
    tmux send-keys -t "$session_name:Document" 'cd bachelorthesis/document' C-m 'v booka4.tex' C-m

    # open novex
    tmux new-window -t $session_name:2 -n 'Novex'
    tmux send-keys -t 'Novex' 'cd experiments/novex' C-m 'v novex/cli.py' C-m
    tmux split-window -t 'Novex' -v
  fi

  # Attach Session, on the Main window
  tmux attach-session -t $session_name
}

gocover() {
  t="/tmp/go-cover.$$.tmp"
  go test -coverprofile=$t $@ && go tool cover -html=$t && unlink $t
}

journal-sync() {
git -C "$HOME/notes" add .
git -C "$HOME/notes" commit -m "updates notes"
git -C "$HOME/notes" pull
git -C "$HOME/notes" push
}

setup-wacom-xournal() {
xsetwacom set "Wacom Intuos BT M Pen stylus" MapToOutput "DP-1-3"
xsetwacom set "Wacom Intuos BT M Pad pad" Button 1 "key +ctrl z -ctrl"
xsetwacom set "Wacom Intuos BT M Pad pad" Button 2 "key +ctrl y -ctrl"
xsetwacom set "Wacom Intuos BT M Pad pad" Button 3 "key +ctrl - -ctrl"
xsetwacom set "Wacom Intuos BT M Pad pad" Button 8 "key +ctrl +shift + -shift -ctrl"
}

setup-wacom-obsidian() {
xsetwacom set "Wacom Intuos BT M Pen stylus" MapToOutput "DP-1-3"
xsetwacom set "Wacom Intuos BT M Pen stylus" Button 1 "button +1"
xsetwacom set "Wacom Intuos BT M Pen stylus" Button 2 "button +2"
xsetwacom set "Wacom Intuos BT M Pen stylus" Button 3 "button +3"

xsetwacom set "Wacom Intuos BT M Pad pad" Button 1 "key +ctrl z -ctrl"
xsetwacom set "Wacom Intuos BT M Pad pad" Button 2 "key +ctrl +shift z -shift -ctrl"
xsetwacom set "Wacom Intuos BT M Pad pad" Button 3 "key +ctrl - -ctrl"
xsetwacom set "Wacom Intuos BT M Pad pad" Button 8 "key +ctrl +shift + -shift -ctrl"
}

cm() {
  # Get the first argument (program name)
  program="$1"

  # Check if the program name is provided
  if [ -z "$program" ]; then
    echo "Error: Please provide a program name as the first argument."
    return
  fi

  # Shift the arguments to remove the first argument (program name)
  shift

  compiler_found=false
  for file_path in /usr/local/share/nvim/runtime/compiler/*.vim; do
    file_name=$(basename "$file_path" .vim)
    if [[ "$file_name" == "$program" ]]; then
      echo "File found: $file_path"
      compiler_found=true
      break
    fi
  done

  if [[ "$compiler_found" == "true" ]]; then
    nvim --cmd "compiler $file_name" -q <("$program" "$@" 2>&1)
  else
    nvim -q <("$program" "$@" 2>&1)
  fi
}
