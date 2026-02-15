vim.pack.add {
  { src = "https://github.com/saghen/blink.cmp", version = "v1.9.1" },
  { src = "https://github.com/rafamadriz/friendly-snippets" },
}

require("blink.cmp").setup {
  keymap = {
    ["<C-e>"] = { "hide", "fallback" },
    ["<C-y>"] = { "select_and_accept", "fallback" },

    ["<Up>"] = { "select_prev", "fallback" },
    ["<Down>"] = { "select_next", "fallback" },
    ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
    ["<C-n>"] = { "select_next", "fallback_to_mappings" },

    ["<C-b>"] = { "scroll_documentation_up", "fallback" },
    ["<C-f>"] = { "scroll_documentation_down", "fallback" },

    ["<Tab>"] = { "snippet_forward", "fallback" },
    ["<S-Tab>"] = { "snippet_backward", "fallback" },
  },
  appearance = {
    nerd_font_variant = "mono",
  },
  completion = {
    documentation = { auto_show = true },
    menu = { auto_show = not vim.list_contains({ "ids-car", "kekpad" }, vim.fn.hostname():lower()), border = "none" },
  },
  sources = {
    default = { "lsp" },
  },
  fuzzy = { implementation = "lua" },
}

vim.keymap.set({ "i" }, "<C-x><C-o>", function()
  require("blink.cmp").show_and_insert { providers = { "lsp", "snippets" } }
end)
