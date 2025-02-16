local utils = require "..utils"

return {
  {
    'akinsho/bufferline.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    version = "*",
    config = true,
    lazy = false,
    opts = {
      options = {
        show_buffer_close_icons = false,
        auto_toggle_bufferline = false,
        indicator = {
          icon = '▎', -- this should be omitted if indicator style is not 'icon'
          style = 'icon',
        },
        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer",
            highlight = "Directory",
            separator = true -- use a "true" to enable the default, or set your own character
          }
        },
      },
    },
    init = function()
      vim.opt.showtabline = utils.if_personal(1, 2)
    end,
    keys = {
      { "gb", "<cmd>BufferLinePick<cr>", desc = "[G]o to [B]uffer" },
      {
        "<leader>tbl",
      function()
        -- vim.o contains a value, vim.opt can contain a table
        if vim.o.showtabline == 2 then
          -- 1 only enables it if there are two tabs
          vim.opt.showtabline = 1
        else
          -- 2 is always enabled
          vim.opt.showtabline = 2
        end
      end,
      desc = "[T]oggle [B]uffer [L]ine",
      }
    },
  }
}
