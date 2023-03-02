local M = {}

Plugin = {}
Plugin.__index = Plugin

M.plugin_list = {}

function Plugin.new(opts)
  local self = setmetatable({}, Plugin)

  self.github = opts[1] or opts.github
  self.url = opts.url
  self.dir = opts.dir
  self.dev = opts.dev
  self.lazy = opts.lazy
  self.dependencies = opts.dependencies
  self.config = opts.config
  self.build = opts.build
  self.cmd = opts.cmd
  self.ft = opts.ft
  self.keys = opts.keys
  self.run = opts.run

  return self
end

function Plugin:to_lazy()
  return {
    [1] = self.github,
    url = self.url,
    dir = self.dir,
    dev = self.dev,
    lazy = self.lazy,
    dependencies = self.dependencies,
    config = self.config,
    build = self.build,
    cmd = self.cmd,
    ft = self.ft,
    keys = self.keys,
    run = self.run,
  }
end

function M.add_plugin(opts)
  table.insert(M.plugin_list, Package.new(opts))
end

function M.add_plugin_list(optss)
  for _, opts in pairs(optss) do
    table.insert(M.plugin_list, Plugin.new(opts))
  end
end

function M.get_lazy_plugin_list()
  return vim.tbl_map(function(x) return x:to_lazy() end, M.plugin_list)
end

return M
