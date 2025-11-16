vim.pack.add {
  { src = "https://github.com/nvim-treesitter/nvim-treesitter",             version = "main" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", version = "main" },
}

local ts = require("nvim-treesitter")
ts.setup({
  install_dir = vim.fn.stdpath('data') .. '/site'
})

local languages = {
  "lua",
  "cpp",
  "python",
  "yaml",
}

if next(ts.get_installed()) == nil then
  ts.install("all")
end

ts.update(languages)

vim.api.nvim_create_autocmd('FileType', {
  pattern = ts.get_installed(),
  callback = function()
    vim.treesitter.start()
    local tso = require("nvim-treesitter-textobjects")
    local select = require("nvim-treesitter-textobjects.select")
    tso.setup {
      select = {
        lookahead = true,
        selection_modes = {
          ['@parameter.outer'] = 'v',
          ['@function.outer'] = 'v',
          ['@class.outer'] = 'V',
        },
        include_surrounding_whitespace = false,
      },
    }

    -- keymaps
    -- You can use the capture groups defined in `textobjects.scm`
    vim.keymap.set({ "x", "o" }, "af", function()
      select.select_textobject("@function.outer", "textobjects")
    end)
    vim.keymap.set({ "x", "o" }, "if", function()
      select.select_textobject("@function.inner", "textobjects")
    end)
    vim.keymap.set({ "x", "o" }, "ac", function()
      select.select_textobject("@class.outer", "textobjects")
    end)
    vim.keymap.set({ "x", "o" }, "ic", function()
      select.select_textobject("@class.inner", "textobjects")
    end)
    vim.keymap.set({ "x", "o" }, "as", function()
      select.select_textobject("@local.scope", "locals")
    end)
  end,
})

vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
