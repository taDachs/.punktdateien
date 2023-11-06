# stuff for automating my study material

export UNI_DIR="$HOME/studium"

# open url in browser
function ilias() {
  COURSE="$(basename $1)"
  $BROWSER "$(yq '.url' $UNI_DIR/current_semester/"$COURSE"/info.yaml | tr -d '"')"
}

# get full name of course
function coursetitle() {
  COURSE="$(basename $1)"
  echo "$(yq '.title' $UNI_DIR/current_semester/"$COURSE"/info.yaml | tr -d '"')"
}

# go to current course or specified by Name
function cdc() {
  if [ -z "$1" ]; then
    cd "$UNI_DIR/current_course"
  else
    cd "$UNI_DIR/current_semester/$1"
  fi
}

# go to current semester
function cds() {
  cd "$UNI_DIR/current_semester"
}


# set the current course using fzf
function scc() {
  if [ -z "$1" ]; then
    NEW_COURSE="$(lsc | fzf)"
  else
    NEW_COURSE="$1"
  fi
  if [ -z "$NEW_COURSE" ]; then
    return 1
  fi
  unlink "$UNI_DIR/current_course"
  ln -s "$UNI_DIR/current_semester/$NEW_COURSE"  "$UNI_DIR/current_course"
}


# list current courses
function lsc() {
  find -L "$UNI_DIR/current_semester" -maxdepth 1 -mindepth 1 -type d -not -name misc -exec basename {} \;
}

function _course_completion() {
  compadd $(lsc)
}

# add completions
compdef _course_completion ilias
compdef _course_completion coursetitle
compdef _course_completion cdc
compdef _course_completion scc
