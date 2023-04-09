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
    },
    keys = {
      {
        "<Tab>",
        function()
          vim.api.nvim_feedkeys(
            vim.api.nvim_replace_termcodes(
              vim.fn.eval "luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' ",
              true,
              true,
              true
            ),
            "n",
            true
          )
        end,
        mode = "i",
        silent = true,
        expr = true,
      },

      {
        "<S-Tab>",
        function()
          require("luasnip").jump(-1)
        end,
        mode = "i",
        silent = true,
        noremap = true,
      },
      {
        "<Tab>",
        function()
          require("luasnip").jump(1)
        end,
        mode = "s",
        silent = true,
        noremap = true,
      },
      {
        "<S-Tab>",
        function()
          require("luasnip").jump(-1)
        end,
        mode = "s",
        silent = true,
        noremap = true,
      },
    },
  },
}

local function setup_snippets()
  local ls = require "luasnip"
  local s = ls.snippet
  local sn = ls.snippet_node
  local isn = ls.indent_snippet_node
  local t = ls.text_node
  local i = ls.insert_node
  local f = ls.function_node
  local c = ls.choice_node
  local d = ls.dynamic_node
  local r = ls.restore_node
  local events = require "luasnip.util.events"
  local ai = require "luasnip.nodes.absolute_indexer"
  local extras = require "luasnip.extras"
  local l = extras.lambda
  local rep = extras.rep
  local p = extras.partial
  local m = extras.match
  local n = extras.nonempty
  local dl = extras.dynamic_lambda
  local fmt = require("luasnip.extras.fmt").fmt
  local fmta = require("luasnip.extras.fmt").fmta
  local conds = require "luasnip.extras.expand_conditions"
  local postfix = require("luasnip.extras.postfix").postfix
  local types = require "luasnip.util.types"
  local parse = require("luasnip.util.parser").parse_snippet

  local function to_snakecase(s) end

  -- python snippets
  ls.add_snippets("python", {
    s(
      "node1",
      f(function(args, parent, user_args)
        return "class "
      end, { 1 })
    ),
  })
end

function M.setup()
  setup_snippets()
end

return M
