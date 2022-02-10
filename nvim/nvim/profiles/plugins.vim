call plug#begin('~/.vim/plugged')
  " misc
	Plug 'jiangmiao/auto-pairs'
  Plug 'kshenoy/vim-signature'
  Plug 'phanviet/vim-monokai-pro'
  Plug 'neovim/nvim-lspconfig'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'tpope/vim-surround'
  Plug 'junegunn/vim-easy-align'
  Plug 'tikhomirov/vim-glsl'
  Plug 'bfrg/vim-cpp-modern'

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

" Telescope
luafile ~/.config/nvim/profiles/lua/telescope.lua
nnoremap <C-a> <cmd>Telescope find_files<cr>
nnoremap <C-f> <cmd>Telescope live_grep<cr>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
