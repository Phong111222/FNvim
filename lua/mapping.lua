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
	local map = vim.keymap.set
	vim.api.nvim_set_keymap("i", "jk", "<ESC>", opts)
	map("t", "<esc><esc>", "<c-\\><c-n>", opts)
	vim.api.nvim_set_keymap(
		"n",
		"<leader>x",
		":lua PromptSaveBeforeClose()<CR>",
		{ noremap = true, silent = true, desc = "Close Current Buffer" }
	)
	map("n", "<leader>a", "G$vgg0", { noremap = true, silent = true, desc = "Select All" })
	map("v", ">", ">gv", { desc = "Indent and reselect" }) -- Indent and reselect
	map("v", "<", "<gv", { desc = "Unindent and reselect" }) -- Unindent and reselect

	map("n", "<leader>W", ":noautocmd w<CR>", { desc = "Save without formatting" })
	map("v", "J", ":m '>+1<CR>gv=gv", opts)
	map("v", "K", ":m '>-2<CR>gv=gv", opts)
	map("v", "<leader>r", '"hy:%s/<C-r>h//g<Left><Left>', { noremap = true, silent = true, desc = "Replace Selection" })
end

return M
