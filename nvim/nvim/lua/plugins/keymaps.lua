local M = {}

function M.setup()

	-- comments
	local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
	vim.keymap.set("n", "<leader>co", require("Comment.api").toggle.linewise.current)
	vim.keymap.set("x", "<leader>co", function()
		vim.api.nvim_feedkeys(esc, "nx", false)
		require("Comment.api").toggle.linewise(vim.fn.visualmode())
	end)

	-- telescope
	vim.keymap.set("n", "<leader>ta", "<cmd>Telescope find_files<cr>", { noremap = true })
	vim.keymap.set("n", "<leader>tf", "<cmd>Telescope live_grep<cr>", { noremap = true })
	vim.keymap.set("n", "<leader>tr", "<cmd>Telescope ros ros<cr>", { noremap = true })
	vim.keymap.set("n", "<leader>tb", "<cmd>Telescope buffers<cr>", { noremap = true })
	vim.keymap.set("n", "<leader>tds", "<cmd>Telescope lsp_document_symbols<cr>", { noremap = true })
	vim.keymap.set("n", "<leader>tws", "<cmd>Telescope lsp_workspace_symbols<cr>", { noremap = true })

	-- ros helper stuff
	vim.keymap.set("n", "<leader>rol", function()
		require("ros-nvim.ros").open_launch_include()
	end, { silent = true, noremap = true })
	vim.keymap.set("n", "<leader>rdm", function()
		require("ros-nvim.ros").show_message_definition()
	end, { silent = true, noremap = true })
	vim.keymap.set("n", "<leader>rds", function()
		require("ros-nvim.ros").show_service_definition()
	end, { silent = true, noremap = true })

	-- vimux
	vim.keymap.set({ "n" }, "<leader>tmc", function()
		local _, val = pcall(function()
			return vim.fn.input "Run Command: "
		end)
		if val == "Keyboard interrupt" then
			return
		end
		vim.cmd('VimuxRunCommand "' .. val .. '"')
	end)
	vim.keymap.set({ "n" }, "<leader>tmr", function()
		vim.cmd "VimuxRunLastCommand"
	end)
end

return M
