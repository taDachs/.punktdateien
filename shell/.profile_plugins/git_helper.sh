#   ____ ___ _____ 
#  / ___|_ _|_   _|
# | |  _ | |  | |  
# | |_| || |  | |  
#  \____|___| |_|  


#  _____ _   _ _   _  ____ _____ ___ ___  _   _ ____  
# |  ___| | | | \ | |/ ___|_   _|_ _/ _ \| \ | / ___| 
# | |_  | | | |  \| | |     | |  | | | | |  \| \___ \ 
# |  _| | |_| | |\  | |___  | |  | | |_| | |\  |___) |
# |_|    \___/|_| \_|\____| |_| |___\___/|_| \_|____/ 

find_git_repos() {
  ignore_pattern="\(3\|\(t\|T\)hi\)rd_\?\(p\|P\)arty"
  if [ "$#" -gt 0 ]; then
    if [ $1 = "-a" ]; then
      ignore_pattern="*"
    fi
  fi
  local repos=`find . -name ".git" -type d | sed 's/\/.git//' | grep -v "$ignore_pattern" | sort`
  for repo in $repos; do
    echo $repo | sed 's/^\.\///'
  done
}

forgit() {
  find_git_repos | xargs -I{} sh -c "echo ========= {} =========; git -C {} $*;"
}

git_sparse_clone() {
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
}

git_split_off() {
  path_to_folder="$1"
  git filter-repo --force --subdirectory-filter "$path_to_folder"
}

#     _    _     ___    _    ____  _____ ____  
#    / \  | |   |_ _|  / \  / ___|| ____/ ___| 
#   / _ \ | |    | |  / _ \ \___ \|  _| \___ \ 
#  / ___ \| |___ | | / ___ \ ___) | |___ ___) |
# /_/   \_\_____|___/_/   \_\____/|_____|____/ 

alias gs="git status"
