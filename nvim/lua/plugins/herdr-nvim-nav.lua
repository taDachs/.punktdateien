return {
  "aimdevlee/herdr-nvim-nav",
  dependencies = { "christoomey/vim-tmux-navigator" },
  config = function()
    require("herdr-nvim-nav").setup()
  end,
}
