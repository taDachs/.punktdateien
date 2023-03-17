local M = {}

M.dependencies = {
  -- snippets
  {
    "L3MON4D3/LuaSnip",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
    dependencies = {
      { dir = "~/Projects/musnips/" },
      { "rafamadriz/friendly-snippets" },
    }
  }
}

return M
