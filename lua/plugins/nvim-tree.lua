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

		local function on_attach(bufnr)
			local api = require("nvim-tree.api")

			local function opts(desc)
				return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
			end

			-- Essential default mappings
			vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
			vim.keymap.set("n", "o", api.node.open.edit, opts("Open"))
			vim.keymap.set("n", "<2-LeftMouse>", api.node.open.edit, opts("Open"))
			vim.keymap.set("n", "v", api.node.open.vertical, opts("Open: Vertical Split"))
			vim.keymap.set("n", "s", api.node.open.horizontal, opts("Open: Horizontal Split"))
			vim.keymap.set("n", "t", api.node.open.tab, opts("Open: New Tab"))
			vim.keymap.set("n", "<Tab>", api.node.open.preview, opts("Open Preview"))
			vim.keymap.set("n", "P", api.node.navigate.parent, opts("Parent Directory"))
			vim.keymap.set("n", "<BS>", api.node.navigate.parent_close, opts("Close Directory"))
			vim.keymap.set("n", "K", api.node.navigate.sibling.first, opts("First Sibling"))
			vim.keymap.set("n", "J", api.node.navigate.sibling.last, opts("Last Sibling"))
			vim.keymap.set("n", "H", api.filter.dotfiles.toggle, opts("Toggle Dotfiles"))
			vim.keymap.set("n", "I", api.filter.git.ignored.toggle, opts("Toggle Git Ignore"))

			vim.keymap.set("n", "R", api.tree.reload, opts("Refresh"))
			vim.keymap.set("n", "a", api.fs.create, opts("Create"))
			vim.keymap.set("n", "d", api.fs.remove, opts("Delete"))
			vim.keymap.set("n", "r", api.fs.rename, opts("Rename"))
			vim.keymap.set("n", "x", api.fs.cut, opts("Cut"))
			vim.keymap.set("n", "c", api.fs.copy.node, opts("Copy"))
			vim.keymap.set("n", "p", api.fs.paste, opts("Paste"))
			vim.keymap.set("n", "q", api.tree.close, opts("Close"))
			-- Copy relative path
			vim.keymap.set("n", "Yr", api.fs.copy.relative_path, opts("Copy Relative Path"))
			-- Copy absolute path
			vim.keymap.set("n", "Ya", api.fs.copy.absolute_path, opts("Copy Absolute Path"))
			-- Copy filename
			vim.keymap.set("n", "Yn", api.fs.copy.filename, opts("Copy Name"))
		end

		nvimtree.setup({
			on_attach = on_attach,
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
				highlight_git = "name",
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
