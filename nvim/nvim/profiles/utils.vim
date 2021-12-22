function EscapeString(s)
  return escape(a:s, '\\/.*$^~[]&')
endfunction

function CommentOut()
  let line = getline('.')
  if !len(line)
    return
  endif
  let comment_string = printf(EscapeString(&commentstring), '.*')
  let comment = match(line, comment_string) >= 0
  if comment
    let comment_text = printf(EscapeString(&commentstring), '\(.*\)')
    execute 's/' . comment_text . '/\1/'
  else
    let whitespace = matchstr(line, '^ *')
    let line_without_whitespace = substitute(line, whitespace, '', '')
    let comment_text = printf(EscapeString(&commentstring), EscapeString(line_without_whitespace))
    execute 's/.*/' . whitespace . comment_text . '/'
  endif
endfunction
