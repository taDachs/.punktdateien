local M = {}

M.dependencies = {
  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = nil,

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
    end,
  },
}

local function jump_to_next_node()
  local ts_util = require "nvim-treesitter.ts_utils"
  local curr = ts_util.get_node_at_cursor(0)
  if curr == nil then
    return
  end
  local next_node = ts_util.get_next_node(curr, true, true)
  if next_node == nil then
    return
  end
  if ts_util.is_parent(curr, next_node) then
    return
  end

  ts_util.goto_node(next_node, false, false)
end

local function jump_to_previous_node()
  local ts_util = require "nvim-treesitter.ts_utils"
  local curr = ts_util.get_node_at_cursor(0)
  if curr == nil then
    return
  end
  local next_node = ts_util.get_previous_node(curr, true, true)
  if ts_util.is_parent(curr, next_node) then
    return
  end
  if next_node == nil then
    return
  end

  ts_util.goto_node(next_node, false, false)
end

M.setup = function()
  vim.keymap.set("n", "<leader>nn", jump_to_next_node, { silent = true, noremap = true })
  vim.keymap.set("n", "<leader>pn", jump_to_previous_node, { silent = true, noremap = true })
end

return M
