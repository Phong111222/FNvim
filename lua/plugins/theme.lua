return {
	{
		"catppuccin/nvim",
		lazy = false,
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({

				transparent_background = true,

				-- optional: tweak styles here
				styles = {
					comments = { "italic" },
					conditionals = { "italic" },
				},
			})
			vim.cmd.colorscheme("catppuccin-mocha")
		end,
	},
}
