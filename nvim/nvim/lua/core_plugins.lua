local M = {}

M.dependencies = {
  {
    "ur4ltz/surround.nvim",
    config = true,
    opts = { mappings_style = "surround", map_insert_mode = false, context_offset = 1 },
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },
  { "christoomey/vim-tmux-navigator" },
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
        -- ["core.completion"] = {
        --   config = {
        --     engine = "nvim-cmp",
        --   },
        -- },
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
}

return M
