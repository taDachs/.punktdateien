-- Define the function
local function vtip()
  -- Run curl and capture output
  local result = vim.fn.system({ "curl", "-s", "-m", "3", "https://vtip.43z.one" })

  -- Trim trailing newline
  result = vim.trim(result or "")

  if result ~= "" then
    vim.notify(result, vim.log.levels.INFO, { title = "Vtip" })
  else
    vim.notify("No tip received.", vim.log.levels.WARN, { title = "Vtip" })
  end
end

-- Create :Vtip command
vim.api.nvim_create_user_command("Vtip", vtip, {})

-- Run automatically on startup
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vtip()
  end,
})
