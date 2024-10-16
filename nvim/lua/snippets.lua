local M = {}

M.dependencies = {
  -- snippets
  {
    "L3MON4D3/LuaSnip",
    config = function()
      require("luasnip").setup({
        enable_autosnippets = true,
        update_events = {"TextChanged", "TextChangedI"},
        region_check_events = {"CursorMoved", "CursorMovedI"},
        delete_check_events = {"TextChanged", "TextChangedI"}
      })
      vim.cmd([[
        imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
        " -1 for jumping backwards.
        inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>

        snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
        snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>

        " For changing choices in choiceNodes (not strictly necessary for a basic setup).
        imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
        smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
      ]])

      require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/luasnippets/"})
    end,
    dependencies = {
    },
    build = "make install_jsregexp",
    -- lazy = false,
  },
}

function M.setup()

end

return M
