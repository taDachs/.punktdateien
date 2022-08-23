local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
  install_path })
end

plugins = require('packer').startup(function()
  -- misc
  use "tversteeg/registers.nvim"
  use 'wbthomason/packer.nvim'
  use {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup({ check_ts = true }) end
  }
  use 'kshenoy/vim-signature' -- for marks in side column
  use 'dstein64/vim-startuptime' -- for marks in side column
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function () require("statusline") end
  }
  use {
    'akinsho/bufferline.nvim',
    tag = "v2.*",
    requires = 'kyazdani42/nvim-web-devicons',
    config = function() require("bufferline").setup({
      -- highlights = {
      --     fill = {
      --       guibg = '#000000',
      --     },
      --     buffer_visible = {
      --       guifg = '#333333',
      --     }
      -- },
      options = {
        -- mode = "tabs"
        show_buffer_close_icons = false,
        show_close_icon = false,
        separator_style = "thick",
        diagnostics = "nvim_lsp",
      }
    }) end
  }
  use {
    "ur4ltz/surround.nvim",
    config = function()
      require"surround".setup {
        mappings_style = "surround",
        map_insert_mode = false,
        context_offset = 1,
      }
    end
  }
  use {
    'kyazdani42/nvim-tree.lua',
    config = function() require("nvim-tree").setup({
      view = {
        mappings = {
          custom_only = true,
          list = {
            { key = { "<CR>", "o" }, action = "edit_no_picker" },
            { key = "O", action = "system_open" },
            { key = "a", action = "create" },
            { key = "s", action = "vsplit" },
            { key = "t", action = "tabnew" },
            { key = "q", action = "close" },
            { key = "r", action = "full_rename" },
            { key = "d", action = "remove" },
            { key = "i", action = "toggle_dotfiles" },
            { key = "y", action = "copy_name" },
            { key = "Y", action = "copy_path" },
            { key = "g?", action = "toggle_help" },
          },
        },
      },
    }) end,
    requires = {"kyazdani42/nvim-web-devicons"},
    opt = true,
    cmd = {"NvimTreeFindFileToggle"}
  }
  use {
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
    -- opt = true,
    -- cmd = {"MarkdownPreview"}
  }
  use {
    "xuhdev/vim-latex-live-preview",
    ft = { 'tex' }
  }
  use 'takac/vim-hardtime'
  use {
    'vim-scripts/DoxygenToolkit.vim',
    opt = true,
    cmd = {"Dox"}
  }
  use {
    "heavenshell/vim-pydocstring",
    run = 'make install',
    ft = { 'python' },
    opt = true,
    cmd = {"Pydocstring"}
  }
  use {
    'norcalli/nvim-colorizer.lua',
    config = function() require('colorizer').setup() end
  }
  use{
    'taketwo/vim-ros',
    opt = true,
    cmd = {"Rosed"}
  }
  use 'christoomey/vim-tmux-navigator'
  use {
    'smjonas/inc-rename.nvim',
    config = function() require("inc_rename").setup() end
  }
  use 'airblade/vim-gitgutter'
  use {
    'numToStr/Comment.nvim',
    config = function() require("Comment").setup({
      mappings = {
        basic = false,
        extra = false,
        extended = false,
      }
    }) end
  }
  use {
    'preservim/tagbar',
    opt = true,
    cmd = {"Tagbar"}
  }

  -- treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function() require("treesitter") end
  }
  use 'nvim-treesitter/nvim-treesitter-textobjects'

  -- colorschemes
  use 'phanviet/vim-monokai-pro'
  use '~/Projects/KIT.vim/'
  use {
    '~/Projects/ros.nvim/',
    config = function() require("ros-nvim").setup({telescope = {only_workspace = true}}) end,
  }
  use {
    '~/Projects/cmp-ros/',
    -- config = function() require("cmp-ros").setup({telescope = {only_workspace = true}}) end,
  }

  -- LSP
  use {
    "williamboman/mason.nvim",
    config = function () require("mason").setup() end,
  }
  use {
    "williamboman/mason-lspconfig.nvim",
    config = function () require("mason-lspconfig").setup({
     automatic_installation = true,
    }) end,
  }
  use 'neovim/nvim-lspconfig'

  use {
    'ray-x/lsp_signature.nvim',
    config = function() require("lsp_signature").setup({hint_prefix = ""}) end
  }

  -- snippets
  use 'L3MON4D3/LuaSnip'
  use 'rafamadriz/friendly-snippets'
  use '~/Projects/musnips/'

  -- completion
  use {
    'hrsh7th/nvim-cmp',
    config = function() require('completion') end
  }
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'saadparwaiz1/cmp_luasnip'
  use 'hrsh7th/cmp-emoji'

  -- telescope
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
  }
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{"nvim-lua/plenary.nvim"}},
    config = function() require('telescope-config') end
  }

  use {
    'tpope/vim-eunuch'
  }
  use {
    'j-hui/fidget.nvim',
    config = function() require"fidget".setup{} end
  }
  use {
    'm-demare/hlargs.nvim',
    requires = { 'nvim-treesitter/nvim-treesitter' },
    config = function() require('hlargs').setup() end

  }

  if packer_bootstrap then
    require('packer').sync()
  end
end)

-- Markdown Preview
vim.g.mkdp_auto_close = 1
vim.g.mkdp_command_for_global = 1
vim.g.mkdp_browser = 'surf'

-- Latex Preview
vim.g.livepreview_previewer = 'zathura'

-- Hard Time
vim.g.hardtime_default_on = 1
vim.g.hardtime_ignore_buffer_patterns = { "Tele*", "NERD.*", "Tag*" }
vim.g.hardtime_ignore_quickfix = 1
vim.g.hardtime_showmsg = 1
vim.g.hardtime_allow_different_key = 1
vim.g.hardtime_maxcount = 3
vim.g.hardtime_motion_with_count_resets = 1

-- git gutter
vim.g.gitgutter_map_keys = 0

-- pydocstring
vim.api.nvim_set_keymap('n', '<nop>', '<Plug>(pydocstring)', { noremap = true })

-- luasnip
require("luasnip.loaders.from_vscode").lazy_load()

return plugins
