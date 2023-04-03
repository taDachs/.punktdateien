local M = {}

M.common_plugins = {
  {
    "tversteeg/registers.nvim",
    config = true,
  },
  {
    "windwp/nvim-autopairs",
    config = true,
    opts = { check_ts = true },
  },
  { "kshenoy/vim-signature" }, -- for marks in side column
  { "dstein64/vim-startuptime", cmd = { "StartupTime" } },
  {
    "ur4ltz/surround.nvim",
    config = true,
    opts = {
      mappings_style = "surround",
      map_insert_mode = false,
      context_offset = 1,
    },
  },
  {
    "iamcco/markdown-preview.nvim",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    config = function()
      vim.g.mkdp_auto_close = 1
      vim.g.mkdp_command_for_global = 1
      vim.g.mkdp_browser = "brave-browser"
    end,
    -- cmd = {"MarkdownPreview"},
  },
  {
    "xuhdev/vim-latex-live-preview",
    ft = { "tex" },
    config = function()
      vim.g.livepreview_previewer = "zathura"
    end,
  },
  {
    "takac/vim-hardtime",
    lazy = false,
    config = function()
      vim.g.hardtime_default_on = 1
      vim.g.hardtime_ignore_buffer_patterns = { "Tele*", "NERD.*", "Tag*" }
      vim.g.hardtime_ignore_quickfix = 1
      vim.g.hardtime_showmsg = 1
      vim.g.hardtime_allow_different_key = 1
      vim.g.hardtime_maxcount = 3
      vim.g.hardtime_motion_with_count_resets = 1
    end,
  },
  {
    "vim-scripts/DoxygenToolkit.vim",
    cmd = { "Dox" },
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },
  { "christoomey/vim-tmux-navigator" },
  { "lewis6991/gitsigns.nvim", config = true },
  {
    "numToStr/Comment.nvim",
    config = true,
    opts = {
      mappings = {
        basic = false,
        extra = false,
        extended = false,
      },
    },
    keys = { "<leader>co" },
  },
  {
    "romainl/vim-cool",
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

  {
    "preservim/vimux",
    cmd = { "VimuxRunCommand", "VimuxRunLastCommand" },
  },

  -- telescope
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = require("plugins.telescope").setup,
  },

  -- neorg
  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    opts = {
      load = {
        ["core.defaults"] = {}, -- Loads default behaviour
        ["core.norg.concealer"] = {}, -- Adds pretty icons to your documents
        -- ["core.norg.journal"] = {}, -- Adds journal
        ["core.norg.dirman"] = { -- Manages Neorg workspaces
          config = {
            workspaces = {
              notes = "~/Documents/Notes/neorg",
            },
            default_workspace = "notes",
          },
        },
      },
    },
    dependencies = { { "nvim-lua/plenary.nvim" } },
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    config = true,
    opts = {
      show_current_context = true,
      -- show_current_context_start = true,
      -- char_highlight_list = {
      --   -- "IndentBlanklineIndent",
      --   },
    },
  },
  -- mystuff
  {
    "tadachs/ros-nvim",
    config = true,
    opts = {},
    dependencies = { "nvim-lua/plenary.nvim" },
    dev = true,
  },
}

return M
