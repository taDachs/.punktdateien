vim.pack.add {
  "https://github.com/tpope/vim-eunuch",
  "https://github.com/folke/which-key.nvim",
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/christoomey/vim-tmux-navigator",
  "https://github.com/folke/todo-comments.nvim",
  "https://github.com/stevearc/stickybuf.nvim",
  "https://github.com/mason-org/mason.nvim",
}

require("which-key").setup()
require("todo-comments").setup({ signs = false })
require("stickybuf").setup()
require("mason").setup()
