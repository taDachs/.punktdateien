count_pages() {
  sum_pages=0
  for file in $@ ; do
    cur_pages=$(pdfinfo $file | awk '/Pages/{print $2}')
    echo "pdf: $file has $cur_pages pages."
    sum_pages=$(( sum_pages + cur_pages))
  done

  echo "All pdf files in this directory have $sum_pages pages."
}

merge_compile_commands() {
  jq -s 'map(.[])' $1/**/compile_commands.json > compile_commands.json
}

inbox() {
  ctx=$(task context show | grep "Context '\(.*\)' with" |cut --delimiter="'" -f 2)

  task context none

  task add "$@" +inbox

  task contex $ctx
}
