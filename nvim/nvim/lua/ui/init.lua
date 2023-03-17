local statusline = require "ui.statusline"
local keymaps = require "ui.keymaps"
local plugins = require "ui.plugins"
local colors = require "ui.colors"
local plugin_list = require "plugins.plugin_list"
local M = {}

function M.setup_dependencies()
  plugin_list.add_plugin_list(plugins.dependencies)
end

function M.setup()
  vim.cmd.colorscheme "kit"
  statusline.setup()
  keymaps.setup()

  vim.cmd([[highlight IndentBlanklineChar guifg=]] .. colors.background_color[6] .. [[ gui=nocombine]])
  vim.cmd([[highlight IndentBlanklineSpaceChar guifg=]] .. colors.background_color[6] .. [[ gui=nocombine]])

  vim.cmd([[highlight IndentBlanklineContextChar guifg=]] .. colors.foreground_color[4] .. [[ gui=nocombine]])
end

return M
