local keymaps = require "plugins.keymaps"
local plugin_list = require "plugins.plugin_list"
local common_plugins = require("plugins.common_plugins").common_plugins
local M = {}

local common_plugin_list = {}

function M.setup()
  local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath,
    }
  end
  vim.opt.rtp:prepend(lazypath)

  plugin_list.add_plugin_list(common_plugins)
  for _, plugin in pairs(plugin_list.plugin_list) do
    -- print(vim.inspect(plugin))
    table.insert(common_plugin_list, plugin)
  end

  require("lazy").setup(common_plugin_list, {
    dev = {
      path = "~/Projects",
    },
  })
  keymaps.setup()
end

return M
