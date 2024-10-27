return {
  -- general QoL stuff
  "tpope/vim-sleuth",
  "tpope/vim-eunuch",
  { -- Useful plugin to show you pending keybinds.
    "folke/which-key.nvim",
    event = "VimEnter", -- Sets the loading event to "VimEnter"
    opts = {},
  },
  { "christoomey/vim-tmux-navigator" },
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
}
