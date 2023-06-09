local M = {}

M.dependencies = {
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
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  },
  {
    "iamcco/markdown-preview.nvim",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    config = function()
      vim.g.mkdp_auto_close = 1
      vim.g.mkdp_command_for_global = 1
      vim.g.mkdp_browser = "firefox"
    end,
    -- cmd = {"MarkdownPreview"},
  },
  -- {
  --   "xuhdev/vim-latex-live-preview",
  --   ft = { "tex" },
  --   config = function()
  --     vim.g.livepreview_previewer = "zathura"
  --   end,
  -- },
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
  {
    "lewis6991/gitsigns.nvim",
    config = true,
    lazy = false,
    keys = {
      { "<leader>gd", "<cmd>Gitsigns preview_hunk<cr>", mode = "n", noremap = true },
    },
  },
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
    keys = {
      {
        "<leader>co",
        function()
          require("Comment.api").toggle.linewise.current()
        end,
        mode = "n",
        noremap = true,
      },
      {
        "<leader>co",
        function()
          local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
          vim.api.nvim_feedkeys(esc, "nx", false)
          require("Comment.api").toggle.linewise(vim.fn.visualmode())
        end,
        mode = "x",
        noremap = true,
      },
    },
  },
  {
    "romainl/vim-cool",
  },

  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    opts = {
      load = {
        ["core.defaults"] = {},
        ["core.concealer"] = {},
        ["core.journal"] = {
          config = {
            journal_folder = "journal",
            workspace = "personal",
          }
        },
        ["core.completion"] = {
          config = {
            engine = "nvim-cmp",
          },
        },
        ["core.dirman"] = {
          config = {
            workspaces = {
              kitcar = "~/notes/kitcar",
              fzi = "~/notes/fzi",
              personal = "~/notes/personal",
              studium = "~/notes/studium",
            },
            default_workspace = "personal",
          },
        },
        ["core.summary"] = {},
      },
    },
    dependencies = { { "nvim-lua/plenary.nvim" } },
    cmd = { "Neorg" },
    ft = { "norg" },
  },

  -- telescope
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true,
    opts = {
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
        },
      },
    },
    keys = {
      { "<leader>ta", "<cmd>Telescope find_files<cr>", mode = "n", noremap = true },
      { "<leader>tf", "<cmd>Telescope live_grep<cr>", mode = "n", noremap = true },
      { "<leader>tb", "<cmd>Telescope buffers<cr>", mode = "n", noremap = true },
      { "<leader><leader>", "<cmd>Telescope buffers<cr>", mode = "n", noremap = true },
      { "<leader>th", "<cmd>Telescope help_tags<cr>", mode = "n", noremap = true },
      { "<leader>tr", "<cmd>Telescope ros ros<cr>", mode = "n", noremap = true },
      { "<leader>tds", "<cmd>Telescope lsp_document_symbols<cr>", mode = "n", noremap = true },
      { "<leader>tws", "<cmd>Telescope lsp_workspace_symbols<cr>", mode = "n", noremap = true },
    },
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    config = true,
    opts = {
      show_current_context = true,
    },
  },

  {
    "dpelle/vim-LanguageTool",
    config = function()
      vim.g.languagetool_jar = "/home/max/Downloads/LanguageTool-5.2/languagetool-commandline.jar"
    end,
  },

  -- mystuff
  {
    "tadachs/ros-nvim",
    config = true,
    opts = {},
    dependencies = { "nvim-lua/plenary.nvim" },
    dev = true,
    keys = {
      {
        "<leader>rol",
        function()
          require("ros-nvim.ros").open_launch_include()
        end,
        silent = true,
        noremap = true,
      },
      {
        "<leader>rd",
        function()
          require("ros-nvim.ros").show_interface_definition()
        end,
        silent = true,
        noremap = true,
      },
    },
  },

  {
    "untitled-ai/jupyter_ascending.vim",
    init = function()
      vim.g.jupyter_ascending_default_mappings = false
    end,
    keys = {
      {
        "<leader>jx",
        "<Plug>JupyterExecute",
        silent = true,
        noremap = true,
      },
      {
        "<leader>jax",
        "<Plug>JupyterExecuteAll",
        silent = true,
        noremap = true,
      },
      {
        "<leader>jr",
        "<Plug>JupyterRestart",
        silent = true,
        noremap = true,
      },
    },
  },

  {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = true,
    cmd = "Neogen"
  },

  -- {
  --   "nvim-orgmode/orgmode",
  --   setup = true,
  -- },
}

return M
