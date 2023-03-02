local plugins = require "treesitter.plugins"
local plugin_list = require("plugins.plugin_list")
local M = {}

function M.setup_dependencies()
  plugin_list.add_plugin_list(plugins.dependencies)
end

function M.setup()
  -- initialize treesitter after ui is drawn
  local treesitterGrp = vim.api.nvim_create_augroup("LazyTreesitter", { clear = true })
  vim.api.nvim_create_autocmd("UIEnter", {
    callback = function()
      require("core.util").delay_function_call(function()
        require "treesitter.config".setup()
      end, 10)
    end,
    group = treesitterGrp,
  })
end

return M
