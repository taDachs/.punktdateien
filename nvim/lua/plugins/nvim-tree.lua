return {
  { "nvim-tree/nvim-web-devicons" },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = { view = { width = 50 } },
    config = function(_, opts)
      require("nvim-tree").setup(opts)

      vim.keymap.set("n", "<leader>tt", function()
        local api = require "nvim-tree.api"
        api.tree.toggle { find_file = true, focus = true, update_root = false }
      end, { desc = "Toggle Tree" })
    end,
  },
}
