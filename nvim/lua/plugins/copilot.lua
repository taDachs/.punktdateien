local utils = require("..utils")

return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = true,
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
    },
    filetypes = {
      ["*"] = true
    },
    cond = utils.is_personal(),
  },
}
