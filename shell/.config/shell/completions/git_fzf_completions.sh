_mu_fzf_complete() {
  setopt localoptions ksh_arrays
  # Split arguments around --
  local args rest str_arg i sep
  args=("$@")
  sep=
  for i in {0..${#args[@]}}; do
    if [[ "${args[$i]-}" = -- ]]; then
      sep=$i
      break
    fi
  done
  if [[ -n "$sep" ]]; then
    str_arg=
    rest=("${args[@]:$((sep + 1)):${#args[@]}}")
    args=("${args[@]:0:$sep}")
  else
    str_arg=$1
    args=()
    shift
    rest=("$@")
  fi
  local fifo lbuf cmd matches post
  fifo="${TMPDIR:-/tmp}/fzf-complete-fifo-$$"
  lbuf=${rest[0]}
  cmd=$(__fzf_extract_command "$lbuf")
  post="${funcstack[1]}_post"
  type $post > /dev/null 2>&1 || post=cat
  _fzf_feed_fifo "$fifo"
  matches=$(FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse --bind=ctrl-z:ignore ${FZF_DEFAULT_OPTS-} ${FZF_COMPLETION_OPTS-} $str_arg" __fzf_comprun "$cmd" "${args[@]}" -q "${(Q)prefix}" < "$fifo" | $post | tr '\n' ' ' | awk '{print $1}')
  if [ -n "$matches" ]; then
    LBUFFER="$lbuf$matches"
  fi
  command rm -f "$fifo"
}

_fzf_complete_git() {
  ARGS="$@"
  _mu_fzf_complete "--sort" "$@" < <(
  { git branch --all | sed 's/\W*\(.*\)/\1 BRANCH/'; git rev-list --all --pretty=oneline --abbrev-commit }
  )
  echo 1
}
