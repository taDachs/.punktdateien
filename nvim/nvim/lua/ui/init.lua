local statusline = require "ui.statusline"
local keymaps = require "ui.keymaps"
local plugins = require "ui.plugins"
local plugin_list = require "plugins.plugin_list"
local M = {}

function M.setup_dependencies()
  plugin_list.add_plugin_list(plugins.dependencies)
end

function M.setup()
  vim.cmd.colorscheme "kit"
  statusline.setup()
  keymaps.setup()
end

return M
