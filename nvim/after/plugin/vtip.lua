-- Fetch a random vim tip from vtip.43z.one and show it as a notification.
---@param silent_on_error boolean don't warn when no tip could be fetched
local function vtip(silent_on_error)
  -- -f: treat HTTP errors (e.g. 502) as failures instead of printing the error page
  vim.system({ "curl", "-sf", "-m", "3", "https://vtip.43z.one" }, { text = true }, function(res)
    local tip = vim.trim(res.stdout or "")
    vim.schedule(function()
      if res.code == 0 and tip ~= "" then
        vim.notify(tip, vim.log.levels.INFO, { title = "Vtip" })
      elseif not silent_on_error then
        vim.notify("No tip received.", vim.log.levels.WARN, { title = "Vtip" })
      end
    end)
  end)
end

vim.api.nvim_create_user_command("Vtip", function()
  vtip(false)
end, {})

-- Run automatically on startup (async, so it never blocks startup)
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vtip(true)
  end,
})
