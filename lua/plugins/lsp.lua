local map = vim.keymap.set
return {
	{
		"williamboman/mason.nvim",
		config = function()
			local mason = require("mason")
			mason.setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			auto_install = true,
		},
	},
	{
		"antosha417/nvim-lsp-file-operations",
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- Uncomment whichever supported plugin(s) you use
			-- "nvim-tree/nvim-tree.lua",
			-- "nvim-neo-tree/neo-tree.nvim",
			-- "simonmclean/triptych.nvim"
		},
		config = function()
			require("lsp-file-operations").setup()
		end,
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local lspconfig = require("lspconfig")
			lspconfig.ts_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.solargraph.setup({
				capabilities = capabilities,
			})
			lspconfig.html.setup({
				capabilities = capabilities,
			})
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})

			map("n", "K", vim.lsp.buf.hover, { desc = "Hover to show description" })
			map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
			map("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
			map("n", "ca", vim.lsp.buf.code_action, { desc = "Code action" })
		end,
	},
}
