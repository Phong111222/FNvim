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

			map("n", "K", vim.lsp.buf.hover, { desc = "Hover To Show Description" })
			map("n", "gd", vim.lsp.buf.definition, { desc = "Go To Definition" })
			map("n", "gr", vim.lsp.buf.references, { desc = "Go To References" })
			map("n", "ca", vim.lsp.buf.code_action, { desc = "Code Action" })
			map("n", "gi", vim.lsp.buf.implementation, { desc = "Go To Implementation" })
			map("n", "<leader>ra", vim.lsp.buf.rename, { desc = "Rename Variable" })
			map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "LSP Diagnostic" })
		end,
	},
}
