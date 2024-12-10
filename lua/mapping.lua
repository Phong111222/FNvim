local M = {}

function PromptSaveBeforeClose()
	if vim.bo.modified then
		local choice = vim.fn.confirm("Save changes before closing?", "&Yes\n&No\n&Cancel")
		if choice == 1 then
			vim.cmd("w|bd") -- Save the file
		elseif choice == 2 then
			if #vim.api.nvim_list_wins() == 1 then
				vim.cmd("enew") -- Quit Neovim if it's the last window
			else
				vim.cmd("close") -- Close the current window
			end
		else
			return -- Cancel the action
		end
	else
		if #vim.api.nvim_list_wins() == 1 then
			vim.cmd("enew") -- Quit Neovim if it's the last window
		else
			vim.cmd("close") -- Close the current window
		end
	end
end

function M.setup()
	local opts = { noremap = true, silent = true }
	vim.api.nvim_set_keymap("i", "jk", "<ESC>", opts)
	vim.api.nvim_set_keymap(
		"n",
		"<leader>x",
		":lua PromptSaveBeforeClose()<CR>",
		{ noremap = true, silent = true, desc = "Close Current Buffer" }
	)
	vim.keymap.set("n", "<leader>a", "G$vgg0", { noremap = true, silent = true, desc = "Select All" })
end

return M
