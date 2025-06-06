return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	config = function()
		local builtin = require("telescope.builtin")
		local map = vim.keymap.set

		map("n", "<leader>ff", function()
			builtin.find_files({
				hidden = true,
				file_ignore_patterns = { "^./.git/", "^node_modules/" }, -- Exclude git directory
			})
		end, { desc = "telescope find files" })

		map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "telescope live grep" })
		map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "telescope find buffers" })
		map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "telescope help page" })
		map("n", "<leader>ma", "<cmd>Telescope marks<CR>", { desc = "telescope find marks" })
		map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "telescope find oldfiles" })
		map(
			"n",
			"<leader>fz",
			"<cmd>Telescope current_buffer_fuzzy_find<CR>",
			{ desc = "telescope find in current buffer" }
		)
		map("n", "<leader>cm", "<cmd>Telescope git_commits<CR>", { desc = "telescope git commits" })
		map("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { desc = "telescope git status" })
		map("n", "<leader>pt", "<cmd>Telescope terms<CR>", { desc = "telescope pick hidden term" })

		require("telescope").setup({
			defaults = {
				prompt_prefix = "   ",
				selection_caret = " ",
				entry_prefix = " ",
				sorting_strategy = "ascending",
				layout_config = {
					horizontal = {
						prompt_position = "top",
						preview_width = 0.55,
					},
					width = 0.87,
					height = 0.80,
				},
				mappings = {
					n = { ["q"] = require("telescope.actions").close },
				},
			},

			extensions_list = { "themes", "terms" },
			extensions = {},
		})
	end,
}
