local function close_environment()
  local row = vim.api.nvim_win_get_cursor(0)[1]
  local current_line = vim.api.nvim_buf_get_lines(0, row - 1, row, true)[1]

  local regex = "\\begin{([^}]+)}"

  -- Test string: \begin{lol}
  local env = string.match(current_line, regex)
  if not env then
    return
  end
  env = "\\end{" .. env .. "}"
  vim.api.nvim_buf_set_lines(0, row, row, true, { env })
  vim.api.nvim_command "normal j==k"
end

function paste_image()
  -- Define the directory to save the image
  local course_dir = os.getenv("HOME") .. "/studium/current_course/notes/"

  -- Ensure the directory exists
  os.execute("mkdir -p " .. course_dir .. "/images")

  local input = vim.fn.input('Enter name for image: ' )

  if #input == 0 then return end

  local image_path = "images/" .. input .. ".png"
  local full_image_path = course_dir .. "/" .. image_path
  local command = "xclip -selection clipboard -t image/png -o > " .. full_image_path

  vim.cmd("silent !"..command)
  vim.notify("Saved image under " .. full_image_path)

  vim.cmd([[normal i\includegraphics{]] .. image_path .. [[}]])
end

vim.keymap.set("n", "<leader>ce", close_environment, { silent = true, noremap = true })
vim.keymap.set("n", "<leader>pi", paste_image, { silent = true, noremap = true })

vim.opt.textwidth = 100

vim.opt.spell = true
