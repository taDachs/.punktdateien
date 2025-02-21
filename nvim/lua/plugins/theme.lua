local utils = require "..utils"
local personal_config = require "personal_config"

return {
  "projekt0n/github-nvim-theme",
  {
    "EdenEast/nightfox.nvim",
    init = function()
      vim.cmd("colorscheme " .. personal_config.dark_theme)
      personal_config.current_theme = personal_config.dark_theme
      -- highlight trailing whitespace
      vim.cmd [[highlight Whitespace ctermbg=red guibg=red]]
    end,
  },
  {
    "f-person/auto-dark-mode.nvim",
    config = true,
    opts = {
      fallback = "light",
      update_interval = 1000,
      set_dark_mode = function()
        vim.notify("Enabling dark mode")
        vim.api.nvim_set_option_value("background", "dark", {})
        vim.cmd("colorscheme " .. personal_config.dark_theme)
        personal_config.current_theme = personal_config.dark_theme
        -- highlight trailing whitespace
        vim.cmd [[highlight Whitespace ctermbg=red guibg=red]]
      end,
      set_light_mode = function()
        vim.notify("Enabling light mode")
        vim.api.nvim_set_option_value("background", "light", {})
        vim.cmd("colorscheme " .. personal_config.light_theme)
        personal_config.current_theme = personal_config.light_theme
        -- highlight trailing whitespace
        vim.cmd [[highlight Whitespace ctermbg=red guibg=red]]
      end,
    },
    cond = utils.is_personal() and not utils.is_docker(),
  },
  {
    "folke/lsp-colors.nvim",
    config = true,
  },
}
