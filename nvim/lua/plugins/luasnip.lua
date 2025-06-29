return {
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      -- optional: provides snippets for the snippet source
      "rafamadriz/friendly-snippets",
    },
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
    opts = {
      region_check_events = {"CursorMoved"},
    },
    config = function(_, opts)
      local ls = require "luasnip"

      ls.setup(opts)

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
      local ms = ls.multi_snippet
      local k = require("luasnip.nodes.key_indexer").new_key

      require("luasnip.loaders.from_vscode").lazy_load {}
      require("luasnip.loaders.from_vscode").lazy_load { paths = { "~/.config/nvim/snippets" } }
    end,
    keys = {
      {
        "<Tab>",
        function()
          local ls = require("luasnip")
          if ls.expand_or_jumpable() then
            return "<Plug>luasnip-expand-or-jump"
          else
            return "<Tab>"
          end
        end,
        mode = { "i", "s" },
        desc = "Expand Snippet Or Jump",
        silent = true,
        expr = true,
      },
      {
        "<S-Tab>",
        function()
          require("luasnip").jump(1)
        end,
        mode = { "i", "s" },
        desc = "Jump Backwards",
        silent = true,
      },
      {
        "<C-E>",
        function()
          if require("luasnip").choice_active() then
            require("luasnip").change_choice(1)
          end
        end,
        mode = { "i", "s" },
        desc = "Change Choice",
        silent = true,
      },
    },
  },
}
