return {
  { "nvim-tree/nvim-tree.lua",
    config = true,
    lazy = false,
    -- opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      {"<leader>tt", ":NvimTreeFindFileToggle<cr>", mode="n", desc="[T]oggle [T]ree"},
    }
  },
}
