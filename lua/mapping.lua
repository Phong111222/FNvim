local M = {}
function M.setup()
	local opts = { noremap = true, silent = true }
	vim.api.nvim_set_keymap("i", "jk", "<ESC>", opts)
end

return M
