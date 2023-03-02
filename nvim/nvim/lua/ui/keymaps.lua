local M = {}

function M.setup()
	-- bufferline
	-- vim.api.nvim_set_keymap('n', 'gt', "<cmd>BufferLineCycleNext<Cr>", { silent = true, noremap = true })
	-- vim.api.nvim_set_keymap('n', 'gT', "<cmd>BufferLineCyclePrev<Cr>", { silent = true, noremap = true })
	vim.keymap.set("n", "<leader>k", "<cmd>BufferLineCycleNext<Cr>", { silent = true, noremap = true })
	vim.keymap.set("n", "<leader>j", "<cmd>BufferLineCyclePrev<Cr>", { silent = true, noremap = true })
	vim.keymap.set("n", "<leader>K", "<cmd>BufferLineMoveNext<Cr>", { silent = true, noremap = true })
	vim.keymap.set("n", "<leader>J", "<cmd>BufferLineMovePrev<Cr>", { silent = true, noremap = true })
	-- vim.api.nvim_set_keymap('n', '<leader>bls', "lua require('bufferline').sort_buffers_by(function (buf_a, buf_b) return buf_a.name < buf_b.name end)", { silent = true, noremap = true })
	vim.keymap.set("n", "<leader>q", "<cmd>bd<Cr>", { silent = true, noremap = true })
	vim.keymap.set("n", "<leader>1", "<cmd>BufferLineGoToBuffer 1<Cr>", { silent = true, noremap = true })
	vim.keymap.set("n", "<leader>2", "<cmd>BufferLineGoToBuffer 2<Cr>", { silent = true, noremap = true })
	vim.keymap.set("n", "<leader>3", "<cmd>BufferLineGoToBuffer 3<Cr>", { silent = true, noremap = true })
	vim.keymap.set("n", "<leader>4", "<cmd>BufferLineGoToBuffer 4<Cr>", { silent = true, noremap = true })
	vim.keymap.set("n", "<leader>5", "<cmd>BufferLineGoToBuffer 5<Cr>", { silent = true, noremap = true })
	vim.keymap.set("n", "<leader>6", "<cmd>BufferLineGoToBuffer 6<Cr>", { silent = true, noremap = true })
	vim.keymap.set("n", "<leader>7", "<cmd>BufferLineGoToBuffer 7<Cr>", { silent = true, noremap = true })
	vim.keymap.set("n", "<leader>8", "<cmd>BufferLineGoToBuffer 8<Cr>", { silent = true, noremap = true })
	vim.keymap.set("n", "<leader>9", "<cmd>BufferLineGoToBuffer 9<Cr>", { silent = true, noremap = true })
end

return M
