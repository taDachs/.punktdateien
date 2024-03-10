count_pages() {
  sum_pages=0
  for file in $@ ; do
    cur_pages=$(pdfinfo $file | awk '/Pages/{print $2}')
    echo "pdf: $file has $cur_pages pages."
    sum_pages=$(( sum_pages + cur_pages))
  done

  echo "All pdf files in this directory have $sum_pages pages."
}
