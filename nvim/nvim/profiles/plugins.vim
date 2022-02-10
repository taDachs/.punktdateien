call plug#begin('~/.vim/plugged')
  " misc
  Plug 'jiangmiao/auto-pairs'
  Plug 'kshenoy/vim-signature'
  Plug 'phanviet/vim-monokai-pro'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'tpope/vim-surround'
  Plug 'junegunn/vim-easy-align'
  Plug 'tikhomirov/vim-glsl'
  Plug 'bfrg/vim-cpp-modern'
  Plug 'preservim/nerdtree'
  Plug 'preservim/nerdcommenter'
  Plug 'udalov/kotlin-vim'

  " LSP
  Plug 'neovim/nvim-lspconfig'
  Plug 'neovim/nvim-lspconfig'
  Plug 'williamboman/nvim-lsp-installer'
  Plug 'simrat39/symbols-outline.nvim'

  " completion
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'quangnguyen30192/cmp-nvim-ultisnips'

  " snippets
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'

  " telescope
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
call plug#end()
filetype plugin on

" Telescope
luafile ~/.config/nvim/profiles/lua/telescope.lua

" NerdCommenter
let g:NERDSpaceDelims = 1

" UltiSnips
set runtimepath+=~/.vim/plugged/musnips/
