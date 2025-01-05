return {
  -- general QoL stuff
  "tpope/vim-sleuth",
  "tpope/vim-eunuch",
  {
    "nicwest/vim-camelsnek",
    keys = {
      { "<leader>gc", "<cmd>Camel<cr>", desc = "[G]o [C]amelcase" },
      { "<leader>gs", "<cmd>Snek<cr>", desc = "[G]o [S]nekcase" },
    }

  },
  { -- Useful plugin to show you pending keybinds.
    "folke/which-key.nvim",
    event = "VimEnter", -- Sets the loading event to "VimEnter"
    opts = {},
  },
  { "christoomey/vim-tmux-navigator" },
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
}
