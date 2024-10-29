local function file_exists(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end

return {
  "projekt0n/github-nvim-theme",
  {
    "f-person/auto-dark-mode.nvim",
    config = true,
    opts = {
      fallback = (function()
      local preferred_color_mode
      if vim.fn.system("hostname"):gsub("%s+", "") == "KekPad" and not file_exists("/.dockerenv")then
        preferred_color_mode = "light"
      else
        preferred_color_mode = "dark"
      end
        return preferred_color_mode
      end)(),
      update_interval = 1000,
      set_dark_mode = function()
        vim.api.nvim_set_option_value('background', 'dark', {})
        vim.cmd("colorscheme github_dark_high_contrast")
      end,
      set_light_mode = function()
        vim.api.nvim_set_option_value('background', 'light', {})
        vim.cmd("colorscheme github_light")
      end,
    },
  },
  {
    "folke/lsp-colors.nvim",
    config = true,
  },
}
