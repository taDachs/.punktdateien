vim.pack.add {
  "https://github.com/echasnovski/mini.nvim",
}

-- Better Around/Inside textobjects
--
-- Examples:
--  - va)  - Visually select Around )paren
--  - yinq - Yank Inside Next Quote
--  - ci'  - Change Inside 'quote
require("mini.ai").setup { n_lines = 500 }

-- Add/delete/replace surroundings (brackets, quotes, etc.)
--
-- - asiw) - [Yank] Surrounding Inner Word )Paren (like in surround)
-- - ds'   - Delete Surround 'quotes
-- - rs)'  - Replace Surround ) '
require("mini.surround").setup {
  mappings = {
    add = "ys", -- Add surrounding in Normal and Visual modes
    delete = "ds", -- Delete surrounding
    find = "", -- Find surrounding (to the right)
    find_left = "", -- Find surrounding (to the left)
    highlight = "", -- Highlight surrounding
    replace = "cs", -- Replace surrounding
    update_n_lines = "", -- Update `n_lines`

    suffix_last = "l", -- Suffix to search with "prev" method
    suffix_next = "n", -- Suffix to search with "next" method
  },
}

require("mini.move").setup {
  mappings = {
    -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
    left = "<M-h>",
    right = "<M-l>",
    down = "<M-j>",
    up = "<M-k>",

    -- Move current line in Normal mode
    line_left = "<M-h>",
    line_right = "<M-l>",
    line_down = "<M-j>",
    line_up = "<M-k>",
  },
}

require("mini.splitjoin").setup {
  mappings = {
    toggle = "<leader>tl",
    split = "",
    join = "",
  },
}

local pick = require "mini.pick"
pick.setup {}

vim.keymap.set("n", "<leader>fh", pick.builtin.help, { desc = "Find Help" })
vim.keymap.set("n", "<leader>ff", pick.builtin.files, { desc = "Find Files" })
vim.keymap.set("n", "<leader>fg", pick.builtin.grep_live, { desc = "Find Grep" })
vim.keymap.set("n", "<leader>fr", pick.builtin.resume, { desc = "Find Resume" })
vim.keymap.set("n", "<leader><space>", pick.builtin.buffers, { desc = "Find existing buffers" })

require("mini.icons").setup {
  lsp = {
    array         = { glyph = '', hl = 'MiniIconsOrange' },
    boolean       = { glyph = '', hl = 'MiniIconsOrange' },
    class         = { glyph = '󱡠', hl = 'MiniIconsPurple' },
    color         = { glyph = '󰏘', hl = 'MiniIconsRed'    },
    constant      = { glyph = '󰏿', hl = 'MiniIconsOrange' },
    constructor   = { glyph = '', hl = 'MiniIconsAzure'  },
    enum          = { glyph = '', hl = 'MiniIconsPurple' },
    enummember    = { glyph = '', hl = 'MiniIconsYellow' },
    event         = { glyph = '', hl = 'MiniIconsRed'    },
    field         = { glyph = '󰜢', hl = 'MiniIconsYellow' },
    file          = { glyph = '󰈔', hl = 'MiniIconsBlue'   },
    folder        = { glyph = '󰉋', hl = 'MiniIconsBlue'   },
    ['function']  = { glyph = '󰊕', hl = 'MiniIconsAzure'  },
    interface     = { glyph = '', hl = 'MiniIconsPurple' },
    key           = { glyph = '', hl = 'MiniIconsYellow' },
    keyword       = { glyph = '', hl = 'MiniIconsCyan'   },
    method        = { glyph = '', hl = 'MiniIconsAzure'  },
    module        = { glyph = '', hl = 'MiniIconsPurple' },
    namespace     = { glyph = '', hl = 'MiniIconsRed'    },
    null          = { glyph = '', hl = 'MiniIconsGrey'   },
    number        = { glyph = '', hl = 'MiniIconsOrange' },
    object        = { glyph = '', hl = 'MiniIconsGrey'   },
    operator      = { glyph = '', hl = 'MiniIconsCyan'   },
    package       = { glyph = '', hl = 'MiniIconsPurple' },
    property      = { glyph = '', hl = 'MiniIconsYellow' },
    reference     = { glyph = '', hl = 'MiniIconsCyan'   },
    snippet       = { glyph = '', hl = 'MiniIconsGreen'  },
    string        = { glyph = '', hl = 'MiniIconsGreen'  },
    struct        = { glyph = '', hl = 'MiniIconsPurple' },
    text          = { glyph = '', hl = 'MiniIconsGreen'  },
    typeparameter = { glyph = '', hl = 'MiniIconsCyan'   },
    unit          = { glyph = '', hl = 'MiniIconsCyan'   },
    value         = { glyph = '', hl = 'MiniIconsBlue'   },
    variable      = { glyph = '󰆦', hl = 'MiniIconsCyan'   },
  },
  style = "glyph",
}
require("mini.icons").tweak_lsp_kind()

local marvin_mode = {
  delay = {
    completion = 100,
    info = 100,
    signatur = 50,
  },
  autocompletion_enabled = true,
}
local normal_mode = {
  delay = {
    completion = 10^7,
    info = 10^7,
    signatur = 10^7,
  },
  autocompletion_enabled = false,
}
local mini_conf = normal_mode

require("mini.completion").setup {
  lsp_completion = {
    source_func = "omnifunc",
  },
  delay = mini_conf.delay,
  window = {
    info = { border = "none" },
    signature = { border = "none" },
  },
  mappings = {
    scroll_up = "<C-b>",
    scroll_down = "<C-f>",
    force_twostep = "",
    force_fallback = "",
  },
}

if not mini_conf.autocompletion_enabled then
  vim.o.completeopt = "fuzzy,menuone,popup"
else
  vim.o.completeopt = "fuzzy,menuone,popup,noinsert"
end

-- We control the triggering manually
vim.g.minicompletion_disable = not mini_conf.autocompletion_enabled

vim.opt.shortmess:append "c"
vim.o.pumheight = 20
