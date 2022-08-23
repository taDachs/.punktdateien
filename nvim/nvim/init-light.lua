-- opts
-- vim.opt.termguicolors = true
vim.opt.syntax = "enabled"

-- softtabs
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- color column
vim.opt.colorcolumn = "100"

-- spelling
vim.opt.spelllang = "en_us"

-- persistent undo
vim.opt.undofile = true

-- relaive numbers
vim.opt.relativenumber = true
vim.opt.number = true

-- yank highlight
local yankGrp = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  command = "silent! lua vim.highlight.on_yank()",
  group = yankGrp,
})

-- remove trailing whitespaces on write
local bufWriteGrp = vim.api.nvim_create_augroup("BufferWrite", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
  command = [[%s/\s\+$//e]],
  group = bufWriteGrp,
})

-- launch files as xml
local rosGrp = vim.api.nvim_create_augroup("Ros", { clear = true })
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = {"*.launch"},
  command = "setf xml",
  group = bufWriteGrp,
})

-- mappings
vim.g.mapleader = '-'

-- jk to esc
vim.api.nvim_set_keymap('i', 'jk', '<esc>', { noremap = true })
vim.api.nvim_set_keymap('i', '<esc>', '<nop>', { noremap = true })

-- copy to clipboard
vim.api.nvim_set_keymap('n', '<leader>c', '"+yy', { noremap = true })
vim.api.nvim_set_keymap('v', '<leader>c', '"+y', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>v', '"+p', { noremap = true })

-- move text
vim.api.nvim_set_keymap('n', 'L', '>>', { noremap = true })
vim.api.nvim_set_keymap('n', 'H', '<<', { noremap = true })
vim.api.nvim_set_keymap('v', 'L', '>`[V`]', { noremap = true })
vim.api.nvim_set_keymap('v', 'H', '<`[V`]', { noremap = true })
vim.api.nvim_set_keymap('v', 'J', 'dp`[V`]', { noremap = true })
vim.api.nvim_set_keymap('v', 'K', 'dkP`[V`]', { noremap = true })

-- dont store {} on jumplist because i dont wanna
vim.api.nvim_set_keymap('n', '}', '<cmd>execute "keepjumps norm! " . v:count1 . "}"<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '{', '<cmd>execute "keepjumps norm! " . v:count1 . "{"<cr>', { noremap = true })

-- remove highlights
vim.api.nvim_set_keymap('n', '<leader><space>', '<cmd>noh<cr>', { noremap = true })


-- plugins
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
  install_path })
end

local packer = require('packer')
--packer.init({
--  package_root = vim.fn.resolve(vim.fn.stdpath('data') .. '/site' .. '/nvim-clean'),
--})
plugins = packer.startup(function(use)
  use 'wbthomason/packer.nvim'
  use {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup({ check_ts = true }) end
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
  use 'christoomey/vim-tmux-navigator'
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require 'nvim-treesitter.configs'.setup {
        ensure_installed = "all",

        sync_install = false,

        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<cr>",
            node_incremental = "<Tab>",
            node_decremental = "<S-Tab>",
          },
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ["<leader>."] = "@parameter.inner",
            },
            swap_previous = {
              ["<leader>,"] = "@parameter.inner",
            },
          },
        },
      }
    end
  }
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use '~/Projects/KIT.vim/'
  use 'bluz71/vim-moonfly-colors'

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function ()
      require('lualine').setup {
        options = {
          icons_enabled = true,
          component_separators = { left = '|', right = '|'},
          section_separators = { left = '', right = ''},
          disabled_filetypes = {},
          always_divide_middle = true,
          globalstatus = false,
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {'branch', 'diff', 'diagnostics'},
          lualine_c = {'filename'},
          lualine_x = {'encoding', 'fileformat', 'filetype'},
          lualine_y = {'progress', function() return vim.fn.line(".") .. "/" .. vim.fn.line("$") end},
          lualine_z = {'location'}
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {'filename'},
          lualine_x = {'location'},
          lualine_y = {},
          lualine_z = {}
        },
        tabline = {},
        extensions = {}
      }
    end
  }

  if packer_bootstrap then
    require('packer').sync()
  end
end)

