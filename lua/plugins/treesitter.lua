return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",

	config = function()
		local treesitter = require("nvim-treesitter.configs")

		treesitter.setup({
			ensure_installed = {
				"luadoc",
				"printf",
				"vim",
				"vimdoc",
				"typescript",
				"javascript",
				"html",
				"vue",
				"svelte",
				"tsx",
				"lua",
			},

			highlight = {
				enable = true,
				use_languagetree = true,
			},

			indent = { enable = true },
			autotag = { enable = true },
		})
	end,
}
