local personal_config = require("personal_config")
local utils = require("utils")

return {
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      bigfile = {},
      picker = {},
      dashboard = {
        enabled = personal_config.splashscreen,
        sections = {
          { section = "terminal", cmd = [[command -v cowsay >/dev/null && command -v fortune >/dev/null && fortune -s | cowsay || echo "no cow found"]], hl = "header", padding = 1, indent = 8 },
          { section = "keys",     gap = 1,                                                                                                               padding = 1 },
          { section = "startup" },
        },
      },
    },
    lazy = false,
    keys = utils.IF(personal_config.picker == "snacks", {
      { "<leader>fh",      function() Snacks.picker.help() end,        mode = "n", desc = "[F]ind [H]elp" },
      { "<leader>fk",      function() Snacks.picker.keymaps() end,     mode = "n", desc = "[F]ind [K]eymaps" },
      { "<leader>ff",      function() Snacks.picker.files() end,       mode = "n", desc = "[F]ind [F]iles" },
      { "<leader>f/",      function() Snacks.picker.grep_word() end,   mode = "n", desc = "[F]ind current word" },
      { "<leader>fg",      function() Snacks.picker.grep() end,        mode = "n", desc = "[F]ind [G]rep" },
      { "<leader>fd",      function() Snacks.picker.diagnostics() end, mode = "n", desc = "[F]ind [D]iagnostics" },
      { "<leader>f.",      function() Snacks.picker.recent() end,      mode = "n", desc = "[F]ind recent files" },
      { "<leader>frr",     function() Snacks.picker.resume() end,      mode = "n", desc = "[F]ind [R]esume" },
      { "<leader><space>", function() Snacks.picker.buffers() end,     mode = "n", desc = "[ ] Find existing buffers" },
    }, {}),
  }
}
