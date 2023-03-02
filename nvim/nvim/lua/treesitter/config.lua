local M = {}

function M.setup()
  require("nvim-treesitter.configs").setup {
    ensure_installed = "all",

    sync_install = false,

    highlight = {
      enable = true,
      additional_vim_regex_highlighting = true,
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

return M
