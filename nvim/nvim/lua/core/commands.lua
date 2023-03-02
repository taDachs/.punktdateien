local M = {}

function M.setup()
	-- Commands
	vim.api.nvim_create_user_command("EditConfig", "tabnew " .. vim.fn.expand "~" .. "/.config/nvim/init.lua", {})
	vim.api.nvim_create_user_command("EditPlugins", "tabnew " .. vim.fn.expand "~" .. "/.config/nvim/lua/plugins.lua", {})
	vim.api.nvim_create_user_command("EditMappings", "tabnew " .. vim.fn.expand "~" .. "/.config/nvim/lua/mappings.lua", {})
end

return M
