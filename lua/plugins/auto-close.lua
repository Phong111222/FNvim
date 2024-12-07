return {
	{
		"m4xshen/autoclose.nvim",
		config = function()
			require("autoclose").setup()
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		event = "InsertEnter", -- Load the plugin only in insert mode
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
}
