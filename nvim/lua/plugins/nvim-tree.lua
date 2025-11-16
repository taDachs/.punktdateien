vim.pack.add {
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/nvim-tree/nvim-tree.lua" },
}

require "nvim-tree".setup({
  view = {
    width = 50,
  },
})

vim.keymap.set("n", "<leader>tt", function()
  local api = require("nvim-tree.api")
  api.tree.toggle({ find_file = true, focus = true, update_root = false })
end, { desc = "Toggle Tree" })
