local M = {}

M.dependencies = {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "kyazdani42/nvim-web-devicons" },
  },
  {
    "akinsho/bufferline.nvim",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    config = true,
    opts = {
      options = {
        -- mode = "tabs"
        show_buffer_close_icons = false,
        show_close_icon = false,
        separator_style = "thick",
        diagnostics = "nvim_lsp",
        numbers = "ordinal",
      },
    },
  },

  -- colorschemes
  "phanviet/vim-monokai-pro",
  { dir = "~/Projects/KIT.vim/" },
  -- mystuff
  {
    "tadachs/ros-nvim",
    config = true,
    opts = {},
    dependencies = { "nvim-lua/plenary.nvim" },
    dev = true,
  },
}

return M
