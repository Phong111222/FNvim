return {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local nvimtree = require("nvim-tree")
		vim.cmd([[
        :hi      NvimTreeExecFile    guifg=#ffa0a0
        :hi      NvimTreeSpecialFile guifg=#ff80ff gui=underline
        :hi      NvimTreeSymlink     guifg=Yellow  gui=italic
        :hi link NvimTreeImageFile   Title
    ]])

		nvimtree.setup({
			filters = {
				dotfiles = false,
				custom = { "^.git$" }, -- Exclude the .git directory but not its contents
			},

			git = {
				ignore = false,
			},

			disable_netrw = true,
			hijack_cursor = true,
			sync_root_with_cwd = true,
			update_focused_file = {
				enable = true,
				update_root = false,
			},
			view = {
				adaptive_size = true,
				preserve_window_proportions = true,
				width = {
					max = 50,
				},
			},
			diagnostics = {
				enable = true,
				icons = {
					hint = "",
					info = "",
					warning = "",
					error = "",
				},
			},

			renderer = {
				root_folder_label = false,
				highlight_git = true,
				indent_markers = { enable = true },
				icons = {
					glyphs = {
						default = "󰈚",
						folder = {
							default = "",
							empty = "",
							empty_open = "",
							open = "",
							symlink = "",
						},
						git = { unmerged = "" },
					},
				},
			},
		})

		vim.keymap.set("n", "<C-n>", "<CMD>NvimTreeToggle<CR>", { desc = "Toggle File Explorer" })

		vim.keymap.set("n", "<leader>e", "<CMD>NvimTreeFocus<CR>", { desc = "Focus Current File" })
	end,
}
