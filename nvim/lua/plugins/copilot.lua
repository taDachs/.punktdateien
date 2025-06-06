local utils = require "..utils"

return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = true,
    opts = {
      suggestion = {
        enabled = true,
        autotrigger = false,
        keymap = {
          accept = "<M-l>",
          accept_word = false,
          accept_line = false,
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
      },
      panel = { enabled = false },
    },
    filetypes = {
      ["*"] = true,
    },
    cond = utils.is_personal(),
  },
}
