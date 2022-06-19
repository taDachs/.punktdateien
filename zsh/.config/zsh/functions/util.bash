# custom functions
forgit() {
    ignore_pattern="./3rdparty"
    find . -name ".git" -type d | sed 's/\/.git//' | grep -v $ignore_pattern |  xargs -I{} sh -c "echo ========= {} =========; git -C {} $*;"
}

mcd() {
  mkdir -p "$1"
  cd "$1"
}

fv() {
  find $@ | fzf | xargs nvim
}
