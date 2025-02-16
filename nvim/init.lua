require "opts"
require "autocommands"
require "keymaps"

local personal_config = require "personal_config"

personal_config.picker = "snacks"
personal_config.use_mini_statusline = true
personal_config.splashscreen = true

-- plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system { "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error("Error cloning lazy.nvim:\n" .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = { import = "plugins" },
  install = { colorscheme = { "carbonfox" } },
  dev = {
    path = "~/development/",
    patterns = {"tadachs"},
    fallback = true,
  },
})
