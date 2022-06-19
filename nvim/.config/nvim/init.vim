syntax enable
set termguicolors

source  ~/.config/nvim/plugins.vim
source  ~/.config/nvim/utils.vim
source ~/.config/nvim/mappings.vim

luafile ~/.config/nvim/lua/completion.lua
luafile ~/.config/nvim/lua/lsp-config.lua
luafile ~/.config/nvim/lua/treesitter.lua
luafile ~/.config/nvim/lua/telescope-config.lua

" softtabs
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set colorcolumn=100


" spelling
set spelllang=en_us

" persistent undo
set undodir=~/.cache/nvim/undodir
set undofile
" relative numbers
set relativenumber
set number
" colorscheme monokai_pro
colorscheme kit
" source ~/Projects/KIT.vim/colors.vim

" removes unnecessary whitespaces
autocmd BufWritePre * %s/\s\+$//e
"
" launch files are 90% xml
autocmd BufRead,BufNewFile *.launch setfiletype xml

set completeopt=menu,menuone,noselect
set omnifunc=v:lua.vim.lsp.omnifunc
