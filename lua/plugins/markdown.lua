return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {
			code = {
				-- Don't paint a background behind code blocks (keeps LSP hover
				-- popups transparent). 'normal' = show language label only.
				style = "nvim",
				-- border = "none",
				highlight = "nvim",
				highlight_inline = "nvim",
			},
		},
	},
	{
		-- Live markdown preview in the browser (mermaid, katex, synced scroll).
		-- Terminal-independent, so diagrams render properly regardless of
		-- wezterm/tmux graphics support.
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function()
			-- Load the plugin first so the autoload function exists during
			-- lazy.nvim's build step (it runs before lazy-loading triggers).
			require("lazy").load({ plugins = { "markdown-preview.nvim" } })
			vim.fn["mkdp#util#install"]()
		end,
		keys = {
			{ "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown preview (browser)", ft = "markdown" },
		},
	},
}
