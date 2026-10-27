-- improve cmd message handling if available
local ok, ui2 = pcall(require, "vim._core.ui2")
if ok and type(ui2.enable) == "function" then
  vim.o.cmdheight = 0
  ui2.enable {
    enable = true,
    msg = { -- Options related to the message module.
      ---@type 'cmd'|'msg' Type of window used to place messages, either in the
      ---cmdline or in a separate ephemeral message box window.
      targets = "msg",
      msg = { timeout = 4000 },
    },
  }
end

-- highlight trailing whitespace
vim.cmd [[match errorMsg /\s\+$/]]
