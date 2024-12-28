-- Create an autocommand group
vim.api.nvim_create_augroup("TerminalSettings", { clear = true })

-- Set up an autocommand for terminal mode
vim.api.nvim_create_autocmd("TermOpen", {
	group = "TerminalSettings",
	callback = function()
		vim.opt_local.relativenumber = false
		vim.opt_local.number = false
	end,
})
