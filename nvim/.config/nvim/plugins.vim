" Automatically install vim-plug if not present
" stolen from https://github.com/fmauch/dot_vim/blob/master/.vim/plugin/plugins.vim
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !sh -c 'curl -fLo ~/.local/share/nvim/site/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.vim/plugged')
  " misc
  Plug 'jiangmiao/auto-pairs'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'kshenoy/vim-signature'
  " Plug 'vim-airline/vim-airline'
  " Plug 'vim-airline/vim-airline-themes'
  Plug 'itchyny/lightline.vim'
  Plug 'tpope/vim-surround'
  Plug 'bfrg/vim-cpp-modern'
  Plug 'preservim/nerdtree'
  Plug 'preservim/nerdcommenter'
  Plug 'udalov/kotlin-vim'
  Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
  Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
  Plug 'takac/vim-hardtime'
  Plug 'vim-scripts/DoxygenToolkit.vim'
  Plug 'heavenshell/vim-pydocstring', { 'do': 'make install', 'for': 'python' }
  Plug 'norcalli/nvim-colorizer.lua'
  Plug 'fatih/vim-go'
  Plug '~/Projects/musnips/'
  Plug 'taketwo/vim-ros'
  Plug 'christoomey/vim-tmux-navigator'

  " treesitter
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'nvim-treesitter/nvim-treesitter-textobjects'

  " colorschemes
  Plug 'phanviet/vim-monokai-pro'
  Plug '~/Projects/KIT.vim/'

  " LSP
  Plug 'neovim/nvim-lspconfig'
  Plug 'williamboman/nvim-lsp-installer'

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
  Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
call plug#end()
filetype plugin on
set nocompatible


" NerdCommenter
let g:NERDSpaceDelims = 1

" Markdown Preview
let g:mkdp_auto_close = 1
let g:mkdp_command_for_global = 1
let g:mkdp_browser = 'surf'

" Latex Preview
let g:livepreview_previewer = 'zathura'

" Hard Time
let g:hardtime_default_on = 1
let g:hardtime_ignore_buffer_patterns = [ "Tele*", "NERD.*" ]
let g:hardtime_ignore_quickfix = 1
let g:hardtime_showmsg = 1
let g:hardtime_allow_different_key = 1
let g:hardtime_maxcount = 3
let g:hardtime_motion_with_count_resets = 1

" nvim colorizer
lua require'colorizer'.setup()

" Ligthline
let g:lightline = {
      \ 'colorscheme': 'kit',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified'] ],
      \ 'right': [ [ 'lineinfo', "line('.') . '/' . line('$')"  ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
\ }

" vim-go
let g:go_doc_keywordprg_enabled = 0
