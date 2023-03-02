local M = {}

Plugin = {}
Plugin.__index = Plugin

M.plugin_list = {}

function M.add_plugin(opts)
  table.insert(M.plugin_list, opts)
end

function M.add_plugin_list(optss)
  for _, opts in pairs(optss) do
    table.insert(M.plugin_list, opts)
  end
end

return M
