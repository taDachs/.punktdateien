local util = {}

function util.delay_function_call(f, delay)
  local timer = vim.loop.new_timer()
  if timer == nil then
    vim.notify("Creating timer failed")
    return
  end
  timer:start(delay, 0, vim.schedule_wrap(f))
end

function util.query_input(text)
  text = text or "User Input"
  local _, val = pcall(function()
    return vim.fn.input(text)
  end)
  if val == "Keyboard interrupt" then
    return
  end
  return val
end

return util
