" Automatically install vim-plug if not present
" stolen from https://github.com/fmauch/dot_vim/blob/master/.vim/plugin/plugins.vim
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !sh -c 'curl -fLo ~/.local/share/nvim/site/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.vim/plugged')
  " misc
  Plug 'jiangmiao/auto-pairs'
  Plug 'kshenoy/vim-signature'
  Plug 'phanviet/vim-monokai-pro'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'tpope/vim-surround'
  Plug 'tikhomirov/vim-glsl'
  Plug 'bfrg/vim-cpp-modern'
  Plug 'preservim/nerdtree'
  Plug 'preservim/nerdcommenter'
  Plug 'udalov/kotlin-vim'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }


  " LSP
  Plug 'neovim/nvim-lspconfig'
  Plug 'williamboman/nvim-lsp-installer'
  " Plug 'simrat39/symbols-outline.nvim'

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
luafile ~/.config/nvim/lua/telescope-config.lua

" NerdCommenter
let g:NERDSpaceDelims = 1

" UltiSnips
set runtimepath+=~/.vim/plugged/musnips/


" Markdown Preview
let g:mkdp_auto_close = 1
let g:mkdp_command_for_global = 1
let g:mkdp_browser = 'surf'
