local core = require "core"
local plugins = require "plugins"

local modules = {
  "lsp",
  "completion",
  "ui",
  "treesitter",
  "snippets",
}

for _, module in pairs(modules) do
  require(module).setup_dependencies()
end

core.setup()
plugins.setup()

for _, module in pairs(modules) do
  require(module).setup()
end
