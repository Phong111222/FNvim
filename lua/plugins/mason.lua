return {
	"williamboman/mason-lspconfig.nvim",
	lazy = false,
	config = function()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"eslint",
				"typos_lsp",
				"html",
				"cssls",
				"lua_ls",
				"ts_ls",
				"tailwindcss",
				"yamlls",
				"dockerls",
				"csharp_ls",
				"pyright",
				"terraformls",
			},
			automatic_installation = true,
		})

		-- Install formatters
		local mason_registry = require("mason-registry")
		local formatters = { "black", "isort", "prettierd", "prettier", "stylua" }

		for _, formatter in ipairs(formatters) do
			if not mason_registry.is_installed(formatter) then
				mason_registry.get_package(formatter):install()
			end
		end
	end,
	dependencies = {
		{

			"williamboman/mason.nvim",
			config = function()
				local mason = require("mason")
				mason.setup()
			end,
		},
		"neovim/nvim-lspconfig",
	},
}
