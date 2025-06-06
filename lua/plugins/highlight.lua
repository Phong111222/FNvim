return {
	"ya2s/nvim-cursorline",
	config = function()
		require("nvim-cursorline").setup({
			cursorline = {
				enable = false,
				timeout = 1000,
				number = false,
			},
			cursorword = {
				enable = true,
				min_length = 3,
				hl = {
					underline = false,
					bg = "#3c3836",
				},
			},
		})
	end,
}
