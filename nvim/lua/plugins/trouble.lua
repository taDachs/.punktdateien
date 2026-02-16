vim.pack.add {
  { src = "https://github.com/folke/trouble.nvim" },
}

local trouble = require "trouble"
trouble.setup {}

local function build_cmd(mode, position, size, filter_opts)
  return function()
    trouble.toggle({
      mode = mode,
      win = {
        position = position,
        size = size,
      },
      filter = filter_opts,
    })
  end
end
      
vim.keymap.set("n", "<leader>x", build_cmd("diagnostics"), { desc = "Diagnostics (Trouble)" })
vim.keymap.set("n", "<leader>xx", build_cmd("diagnostics", nil, nil, { buf = 0 }), { desc = "Buffer Diagnostics (Trouble)" })
vim.keymap.set("n", "<leader>cs", build_cmd("symbols", "right", 0.25), { desc = "Symbols (Trouble)" })
vim.keymap.set("n", "<leader>cl", build_cmd("lsp", "right", 0.25), { desc = "LSP Definitions / references / ... (Trouble)" })
vim.keymap.set("n", "<leader>xl", build_cmd("loclist"), { desc = "Location List (Trouble)" })
vim.keymap.set("n", "<leader>xq", build_cmd("qflist"), { desc = "Quickfix List (Trouble)" })

vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  callback = function()
    vim.cmd([[Trouble qflist open]])
  end,
})
