local modules = {
  "core_plugins",
  "treesitter",
  "completion",
  "ui",
  "lsp",
  "snippets",
  "latex",
  "ai",
}

-- core has to be loaded first to enable otps & co
require("core").setup()

local loaded_modules = {}

for _, module in pairs(modules) do
  local ok, plugins = pcall(require, module)
  if ok then
    table.insert(loaded_modules, plugins)
  else
    vim.notify("Failed loading module: " .. module)
  end
end

local plugin_list = {}

for _, module in pairs(loaded_modules) do
  if module.dependencies ~= nil then
    for _, v in pairs(module.dependencies) do
      table.insert(plugin_list, v)
    end
  end
end

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end

vim.opt.rtp:prepend(lazypath)
require("lazy").setup(plugin_list, {
  dev = {
    path = "~/dev",
  },
})

for _, module in pairs(loaded_modules) do
  if module.setup ~= nil then
    module.setup()
  end
end
