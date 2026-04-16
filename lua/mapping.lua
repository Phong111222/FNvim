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

local claude_pane_id = nil

function OpenClaudeCodeForDirectoryWithTmux()
	local current_dir = vim.fn.getcwd()

	if claude_pane_id then
		local exists = vim.fn.system("tmux display-message -t " .. claude_pane_id .. ' -p "#{pane_id}" 2>/dev/null')
		if exists:match("%S") then
			-- pane is visible, just kill it
			vim.fn.system("tmux kill-pane -t " .. claude_pane_id)
			claude_pane_id = nil
			return
		end
	end

	-- open new pane
	local pane_id =
		vim.fn.system(string.format('tmux split-window -h -l 30%% -c "%s" -P -F "#{pane_id}" "claude -r"', current_dir))
	claude_pane_id = pane_id:gsub("%s+", "")
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

	-- LSP keybindings (keeping your custom bindings + new Neovim 0.11 defaults)
	-- Your custom keybindings
	map("n", "K", vim.lsp.buf.hover, { desc = "Hover To Show Description" })
	map("n", "gd", vim.lsp.buf.definition, { desc = "Go To Definition" })
	map("n", "gr", function()
		require("telescope.builtin").lsp_references()
	end, { desc = "Go To References (Telescope)" })
	map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
	map("n", "gi", vim.lsp.buf.implementation, { desc = "Go To Implementation" })
	map("n", "<leader>ra", vim.lsp.buf.rename, { desc = "Rename Variable" })
	map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "LSP Diagnostic" })
	map("n", "<leader>dw", function()
		vim.diagnostic.setqflist({ open = true }) -- Add all workspace diagnostics to the quickfix list
	end, { desc = "Show workspace diagnostics" })

	vim.keymap.set("n", "<leader>cc", OpenClaudeCodeForDirectoryWithTmux, { desc = "Toggle Claude Code pane" })

	-- Neovim 0.11 default keybindings (alternative ways to access same features)
	map("n", "grn", vim.lsp.buf.rename, { desc = "LSP Rename (0.11 default)" })
	map("n", "grr", vim.lsp.buf.references, { desc = "LSP References (0.11 default)" })
	map("n", "gri", vim.lsp.buf.implementation, { desc = "LSP Implementation (0.11 default)" })
	map("n", "gra", vim.lsp.buf.code_action, { desc = "LSP Code Action (0.11 default)" })

	-- Inlay hints toggle keybinding
	map("n", "<leader>ih", function()
		vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
	end, { desc = "Toggle Inlay Hints" })
end

return M
