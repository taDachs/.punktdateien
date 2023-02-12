local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end

vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
  -- misc
  {
    "tversteeg/registers.nvim",
    config = true,
  },
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup { check_ts = true }
    end,
  },
  "kshenoy/vim-signature", -- for marks in side column
  { "dstein64/vim-startuptime", cmd = { "StartupTime" } },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    config = function()
      require "statusline"
    end,
  },
  {
    "akinsho/bufferline.nvim",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    config = function()
      require("bufferline").setup {
        options = {
          -- mode = "tabs"
          show_buffer_close_icons = false,
          show_close_icon = false,
          separator_style = "thick",
          diagnostics = "nvim_lsp",
          numbers = "ordinal",
        },
      }
    end,
  },
  {
    "ur4ltz/surround.nvim",
    config = function()
      require("surround").setup {
        mappings_style = "surround",
        map_insert_mode = false,
        context_offset = 1,
      }
    end,
    -- keys = { "s", "ys" },
  },
  {
    "iamcco/markdown-preview.nvim",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    -- cmd = {"MarkdownPreview"},
  },
  {
    "xuhdev/vim-latex-live-preview",
    ft = { "tex" },
  },
  { "takac/vim-hardtime", lazy = false },
  {
    "vim-scripts/DoxygenToolkit.vim",
    cmd = { "Dox" },
  },
  {
    "heavenshell/vim-pydocstring",
    build = "make install",
    ft = { "python" },
    cmd = { "Pydocstring" },
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = true,
  },
  -- --  use{
  -- --    'taketwo/vim-ros',
  -- --    opt = true,
  -- --    cmd = {"Rosed"}
  -- --  }
  "christoomey/vim-tmux-navigator",
  {
    "smjonas/inc-rename.nvim",
    config = true,
    cmd = "IncRename",
  },
  "airblade/vim-gitgutter",
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup {
        mappings = {
          basic = false,
          extra = false,
          extended = false,
        },
      }
    end,
    keys = { "<leader>co" },
  },

  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    lazy = true,
  },
  "nvim-treesitter/nvim-treesitter-textobjects",

  -- colorschemes
  "phanviet/vim-monokai-pro",
  { dir = "~/Projects/KIT.vim/" },

  -- mystuff
  {
    "tadachs/ros-nvim",
    config = function()
      require("ros-nvim").setup { only_workspace = true }
    end,
    dependencies = { "tadachs/mutils.nvim" },
    dev = true,
  },
  {
    "tadachs/mutils.nvim",
    dev = true,
  },

  -- LSP
  {
    "williamboman/mason.nvim",
    config = true,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup {
        automatic_installation = true,
      }
    end,
  },
  "neovim/nvim-lspconfig",

  {
    "ray-x/lsp_signature.nvim",
    config = function()
      require("lsp_signature").setup { hint_prefix = "" }
    end,
  },

  -- snippets
  "L3MON4D3/LuaSnip",
  "rafamadriz/friendly-snippets",
  { dir = "~/Projects/musnips/" },

  -- -- completion
  {
    "hrsh7th/nvim-cmp",
    config = function()
      require "completion"
    end,
  },
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "saadparwaiz1/cmp_luasnip",
  "hrsh7th/cmp-emoji",

  -- telescope
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true,
  },
  {
    "j-hui/fidget.nvim",
    config = true,
  },

  {
    "m-demare/hlargs.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = true,
  },
  {
    "tamton-aquib/duck.nvim",
    config = function()
      vim.keymap.set("n", "<leader>dd", function()
        for i = 1, 1, 1 do
          require("duck").hatch()
        end
      end, {})
      vim.keymap.set("n", "<leader>dk", function()
        require("duck").cook()
      end, {})
    end,
  },

  -- {
  --   "aduros/ai.vim"
  -- },

  "cshuaimin/ssr.nvim",
  {
    "preservim/vimux",
    cmd = { "VimuxRunCommand", "VimuxRunLastCommand" },
  },
  { url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim", config = true },
  { "rmagatti/goto-preview", config = true },
  { "simrat39/symbols-outline.nvim", config = true },
  { "folke/lsp-colors.nvim", config = true },
  { "folke/trouble.nvim", config = true },
}, {
  dev = {
    path = "~/Projects",
  },
})

-- Markdown Preview
vim.g.mkdp_auto_close = 1
vim.g.mkdp_command_for_global = 1
vim.g.mkdp_browser = "surf"

-- Latex Preview
vim.g.livepreview_previewer = "zathura"

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

-- ai.vim
vim.g.ai_no_mappings = 1

-- pydocstring
vim.api.nvim_set_keymap("n", "<nop>", "<Plug>(pydocstring)", { noremap = true })

-- luasnip
require("luasnip.loaders.from_vscode").lazy_load()

-- initialize treesitter after ui is drawn
local treesitterGrp = vim.api.nvim_create_augroup("LazyTreesitter", { clear = true })
vim.api.nvim_create_autocmd("UIEnter", {
  command = 'lua require("mutils").delay_function_call(function() require("treesitter") end, 10)',
  group = treesitterGrp,
})

return plugins
