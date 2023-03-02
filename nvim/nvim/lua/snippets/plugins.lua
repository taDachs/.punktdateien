local M = {}

M.dependencies = {
  -- snippets
  {
    "L3MON4D3/LuaSnip",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
  { "rafamadriz/friendly-snippets" },
  { dir = "~/Projects/musnips/" },
}

return M
