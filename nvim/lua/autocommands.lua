-- autocommands
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- setf .devcontainer.json and devcontainer.json to jsonc
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  desc = "Set filetype for .devcontainer.json and devcontainer.json to jsonc",
  group = vim.api.nvim_create_augroup("devcontainer-jsonc", { clear = true }),
  pattern = ".devcontainer.json,devcontainer.json",
  callback = function()
    vim.bo.filetype = "jsonc"
  end,
})

-- make help window split vertical
vim.api.nvim_create_autocmd("FileType", {
  desc = "make help split vertical",
  pattern= {"help", "h"},
  command = "wincmd L",
  group = vim.api.nvim_create_augroup("VerticalHelp", { clear = true })
})
