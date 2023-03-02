local configs = require "lsp.config"
local keymaps = require "lsp.keymaps"
local commands = require "lsp.commands"
local plugins = require "lsp.plugins"

local plugin_list = require "plugins.plugin_list"

local M = {}

function M.setup_dependencies()
  plugin_list.add_plugin_list(plugins.dependencies)
end

function M.setup()
  configs.setup()
  keymaps.setup()
  commands.setup()
end

return M
