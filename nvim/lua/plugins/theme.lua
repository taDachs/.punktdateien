local utils = require("..utils")

return {
  "projekt0n/github-nvim-theme",
  {
    "EdenEast/nightfox.nvim",
    init = function()
      vim.cmd("colorscheme carbonfox")
      -- highlight trailing whitespace
      vim.cmd [[highlight Whitespace ctermbg=red guibg=red]]
    end,
  },
  {
    "f-person/auto-dark-mode.nvim",
    config = true,
    opts = {
      fallback = "dark",
      update_interval = 1000,
      set_dark_mode = function()
        vim.api.nvim_set_option_value('background', 'dark', {})
        vim.cmd("colorscheme carbonfox")
        -- highlight trailing whitespace
      vim.cmd [[highlight Whitespace ctermbg=red guibg=red]]
      end,
      set_light_mode = function()
        vim.api.nvim_set_option_value('background', 'light', {})
        vim.cmd("colorscheme dayfox")
        -- highlight trailing whitespace
        vim.cmd [[highlight Whitespace ctermbg=red guibg=red]]
      end,
    },
    cond = utils.is_personal(),
  },
  {
    "folke/lsp-colors.nvim",
    config = true,
  },
}
