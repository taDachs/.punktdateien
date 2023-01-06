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

function open_ros_launch_include()
  -- Get the current visual selection
  vim.api.nvim_command('normal "vya"')
  local visual_selection = vim.fn.getreg('v')

  local regex = "$%(find ([%a%d_]+)%)(/[%a%d_%.%~/-]+)"

  -- <include file="$(find biobots_husky_sim)/launch/gazebo.xml.launch"/>
  local package, file = string.match(visual_selection, regex)
  --
  if package and file then
  --   -- Open the file "foo"
    local output = io.popen("rospack find " .. package):read('*all')
    output = string.gsub(output, "\n$", "")
    local path = output..file
    vim.api.nvim_command('edit ' .. path)
  end
end
