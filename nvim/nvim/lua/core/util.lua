local util = {}

function util.delay_function_call(f, delay)
  local timer = vim.loop.new_timer()
  timer:start(delay, 0, vim.schedule_wrap(f))
end

return util
