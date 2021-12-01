source  ~/.config/nvim/profiles/plugins.vim
source  ~/.config/nvim/profiles/utils.vim
source  ~/.config/nvim/profiles/lsp-config.vim
luafile ~/.config/nvim/profiles/lua/completion.lua

" softtabs
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" persistent undo
set undodir=~/.cache/nvim/undodir
set undofile

syntax enable
colorscheme monokai_pro

" relative numbers
set relativenumber

map <C-_> :call CommentOut()<Cr>

" removes unnecessary whitespaces
autocmd BufWritePre * %s/\s\+$//e
"
" launch files are 90% xml
autocmd BufRead,BufNewFile *.launch setfiletype xml
autocmd FileType * call LoadLanguageEnvironment()

set completeopt=menu,menuone,noselect
setlocal omnifunc=v:lua.vim.lsp.omnifunc

function LoadLanguageEnvironment()
  if &filetype == "python"
    source ~/.config/nvim/profiles/languages/python.vim
  elseif &filetype == "vim"
    source ~/.config/nvim/profiles/languages/vim.vim
  elseif &filetype == "cpp"
    source ~/.config/nvim/profiles/languages/cpp.vim
  endif
endfunction
