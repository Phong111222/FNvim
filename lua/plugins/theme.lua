return {
	-- Catppuccin theme
	{
		"catppuccin/nvim",
		lazy = false,
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				transparent_background = true,
				styles = {
					comments = { "italic" },
					conditionals = { "italic" },
				},
			})
		end,
	},

	-- Tokyo Night theme
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("tokyonight").setup({
				transparent = true,
				styles = {
					comments = { italic = true },
					keywords = { italic = true },
				},
			})
		end,
	},

	-- Gruvbox theme
	{
		"ellisonleao/gruvbox.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("gruvbox").setup({
				transparent_mode = true,
				italic = {
					strings = false,
					comments = true,
					operators = false,
					folds = true,
				},
			})
		end,
	},

	-- Nord theme
	{
		"shaunsingh/nord.nvim",
		lazy = false,
		priority = 1000,
	},

	-- Kanagawa theme
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("kanagawa").setup({
				transparent = true,
				commentStyle = { italic = true },
				keywordStyle = { italic = true },
			})
		end,
	},

	-- Rose Pine theme
	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = false,
		priority = 1000,
		config = function()
			require("rose-pine").setup({
				disable_background = true,
				styles = {
					italic = true,
					transparency = true,
				},
			})
		end,
	},

	-- Theme Switcher Configuration
	{
		"zaldih/themery.nvim",
		lazy = false,
		priority = 999,
		config = function()
			require("themery").setup({
				themes = {
					-- Catppuccin variants
					{ name = "Catppuccin Mocha", colorscheme = "catppuccin-mocha" },
					{ name = "Catppuccin Latte", colorscheme = "catppuccin-latte" },
					{ name = "Catppuccin Frappe", colorscheme = "catppuccin-frappe" },
					{ name = "Catppuccin Macchiato", colorscheme = "catppuccin-macchiato" },
					-- Tokyo Night variants
					{ name = "Tokyo Night", colorscheme = "tokyonight" },
					{ name = "Tokyo Night Storm", colorscheme = "tokyonight-storm" },
					{ name = "Tokyo Night Day", colorscheme = "tokyonight-day" },
					{ name = "Tokyo Night Moon", colorscheme = "tokyonight-moon" },
					-- Gruvbox variants
					{ name = "Gruvbox Dark", colorscheme = "gruvbox" },
					-- Nord
					{ name = "Nord", colorscheme = "nord" },
					-- Kanagawa variants
					{ name = "Kanagawa Wave", colorscheme = "kanagawa-wave" },
					{ name = "Kanagawa Dragon", colorscheme = "kanagawa-dragon" },
					{ name = "Kanagawa Lotus", colorscheme = "kanagawa-lotus" },
					-- Rose Pine variants
					{ name = "Rose Pine", colorscheme = "rose-pine" },
					{ name = "Rose Pine Moon", colorscheme = "rose-pine-moon" },
					{ name = "Rose Pine Dawn", colorscheme = "rose-pine-dawn" },
				},
				livePreview = true, -- Live preview when selecting theme
			})

			-- Set default theme
			vim.cmd.colorscheme("catppuccin-mocha")

			-- Theme switcher keybindings
			vim.keymap.set("n", "<leader>th", ":Themery<CR>", { desc = "Open theme selector" })
		end,
	},
}
