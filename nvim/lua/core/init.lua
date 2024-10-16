local keymaps = require "core.keymaps"
local commands = require "core.commands"
local autocommands = require "core.autocommands"
local opts = require "core.opts"

local M = {}

function M.setup()
  keymaps.setup()
  commands.setup()
  autocommands.setup()
  opts.setup()
end

return M
