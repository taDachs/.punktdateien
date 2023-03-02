local core = require "core"
local plugins = require "plugins"
local lsp = require "lsp"
local completion = require "completion"
local ui = require "ui"
local treesitter = require "treesitter"
local snippets = require "snippets"

lsp.setup_dependencies()
completion.setup_dependencies()
ui.setup_dependencies()
treesitter.setup_dependencies()
snippets.setup_dependencies()

core.setup()
plugins.setup()
lsp.setup()
completion.setup()
ui.setup()
treesitter.setup()
snippets.setup()
