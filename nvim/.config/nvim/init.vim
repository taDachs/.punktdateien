source  ~/.config/nvim/plugins.vim
source  ~/.config/nvim/utils.vim
source ~/.config/nvim/mappings.vim

luafile ~/.config/nvim/lua/completion.lua
luafile ~/.config/nvim/lua/lsp-config.lua
luafile ~/.config/nvim/lua/treesitter.lua

" softtabs
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" spelling
set spelllang=en_us

" persistent undo
set undodir=~/.cache/nvim/undodir
set undofile

syntax enable
colorscheme monokai_pro

" relative numbers
set relativenumber
set number

" removes unnecessary whitespaces
autocmd BufWritePre * %s/\s\+$//e
"
" launch files are 90% xml
autocmd BufRead,BufNewFile *.launch setfiletype xml

set completeopt=menu,menuone,noselect
setlocal omnifunc=v:lua.vim.lsp.omnifunc

