local personal_config = require 'personal_config'
return {
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - asiw) - [Yank] [S]urrounding [I]nner [W]ord [)]Paren (like in surround)
      -- - ds'   - [D]elete [S]urround [']quotes
      -- - rs)'  - [R]eplace [S]urround [)] [']
      require('mini.surround').setup({
        mappings = {
          add = 'ys',          -- Add surrounding in Normal and Visual modes
          delete = 'ds',       -- Delete surrounding
          find = '',           -- Find surrounding (to the right)
          find_left = '',      -- Find surrounding (to the left)
          highlight = '',      -- Highlight surrounding
          replace = 'cs',      -- Replace surrounding
          update_n_lines = '', -- Update `n_lines`

          suffix_last = 'l',   -- Suffix to search with "prev" method
          suffix_next = 'n',   -- Suffix to search with "next" method
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
          toggle = 'gS',
          split = '',
          join = '',
        },
      })

      if personal_config.use_mini_statusline then
        vim.notify("Using mini.nvim statusline")
        -- Simple and easy statusline.
        --  You could remove this setup call if you don't like it,
        --  and try some other statusline plugin
        local statusline = require 'mini.statusline'
        -- set use_icons to true if you have a Nerd Font
        statusline.setup { use_icons = vim.g.have_nerd_font }

        -- You can configure sections in the statusline by overriding their
        -- default behavior. For example, here we set the section for
        -- cursor location to LINE:COLUMN
        ---@diagnostic disable-next-line: duplicate-set-field
        statusline.section_location = function()
          return '%2l:%-2v'
        end
      end
    end,
  },
}
