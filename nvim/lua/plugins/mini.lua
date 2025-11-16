vim.pack.add {
  "https://github.com/echasnovski/mini.nvim",
}

-- Better Around/Inside textobjects
--
-- Examples:
--  - va)  - Visually select Around )paren
--  - yinq - Yank Inside Next Quote
--  - ci'  - Change Inside 'quote
require('mini.ai').setup { n_lines = 500 }

-- Add/delete/replace surroundings (brackets, quotes, etc.)
--
-- - asiw) - [Yank] Surrounding Inner Word )Paren (like in surround)
-- - ds'   - Delete Surround 'quotes
-- - rs)'  - Replace Surround ) '
require('mini.surround').setup({
  mappings = {
    add = 'ys',              -- Add surrounding in Normal and Visual modes
    delete = 'ds',           -- Delete surrounding
    find = '',               -- Find surrounding (to the right)
    find_left = '',          -- Find surrounding (to the left)
    highlight = '',          -- Highlight surrounding
    replace = 'cs',          -- Replace surrounding
    update_n_lines = '',     -- Update `n_lines`

    suffix_last = 'l',       -- Suffix to search with "prev" method
    suffix_next = 'n',       -- Suffix to search with "next" method
  },
})

require('mini.move').setup({
  mappings = {
    -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
    left = '<M-h>',
    right = '<M-l>',
    down = '<M-j>',
    up = '<M-k>',

    -- Move current line in Normal mode
    line_left = '<M-h>',
    line_right = '<M-l>',
    line_down = '<M-j>',
    line_up = '<M-k>',
  },

})

require('mini.splitjoin').setup({
  mappings = {
    toggle = '<leader>tl',
    split = '',
    join = '',
  },
})

local pick = require('mini.pick')
pick.setup({})

vim.keymap.set("n", "<leader>fh", pick.builtin.help, { desc = "Find Help", })
vim.keymap.set("n", "<leader>ff", pick.builtin.files, { desc = "Find Files", })
vim.keymap.set("n", "<leader>fg", pick.builtin.grep_live, { desc = "Find Grep", })
vim.keymap.set("n", "<leader>fr", pick.builtin.resume, { desc = "Find Resume", })
vim.keymap.set("n", "<leader><space>", pick.builtin.buffers, { desc = "Find existing buffers", })
