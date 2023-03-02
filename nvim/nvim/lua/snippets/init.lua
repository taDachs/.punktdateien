local plugins = require "snippets.plugins"
local keymaps = require "snippets.keymaps"
local plugin_list = require "plugins.plugin_list"
local M = {}

function M.setup_dependencies()
  plugin_list.add_plugin_list(plugins.dependencies)
end

function M.setup()
  keymaps.setup()
end

return M
