function commandToBuffer()
  -- this weird wrapping is so the keyboard interrupt is caught
  local _, val = pcall(function() return vim.fn.input("Run Command: ") end)
  if (val == "Keyboard interrupt") then
    return
  end
  vim.cmd("normal ggdG")
  vim.cmd("r! " .. val)
  vim.cmd("normal ggdd")
  vim.cmd("redraw")
  commandToBuffer()
end

