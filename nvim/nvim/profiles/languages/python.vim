"set foldmethod=indent

noremap <C-l> <CMD>w<CR><CMD>silent !yapf -i %<CR><CMD>e %<CR>
