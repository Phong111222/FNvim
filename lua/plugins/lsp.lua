local map = vim.keymap.set
return {
	{
		"mason-org/mason.nvim",
		config = function()
			local mason = require("mason")
			mason.setup()
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {},
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"eslint",
					"typos_lsp",
					"html",
					"lua_ls",
					"tailwindcss",
					"typos_lsp",
					"yamlls",
					"dockerls",
					"csharp_ls",
				},
			})
		end,
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
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {},
	},

	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local lspconfig = require("lspconfig")

			lspconfig.eslint.setup({
				capabilities = capabilities,
				settings = {
					validate = { "javascript", "typescript" }, -- Enable for JS and TS files
					lint = {
						enable = true, -- Enable linting
					},
				},
			})

			require("typescript-tools").setup({
				settings = {
					tsserver_file_preferences = {
						includeInlayParameterNameHints = "all",
						includeCompletionsForModuleExports = true,
						quotePreference = "auto",
					},
					tsserver_plugins = {
						-- for TypeScript v4.9+
						"@styled/typescript-styled-plugin",
						-- or for older TypeScript versions
						-- "typescript-styled-plugin",
					},
					tsserver_format_options = {
						allowIncompleteCompletions = false,
						allowRenameOfImportPath = false,
					},
				},
			})

			-- lspconfig.ts_ls.setup({
			-- 	capabilities = capabilities,
			-- 	settings = {
			-- 		typescript = {
			-- 			inlayHints = {
			-- 				includeInlayParameterNameHints = "all",
			-- 			},
			-- 		},
			-- 		javascript = {
			-- 			inlayHints = {
			-- 				includeInlayParameterNameHints = "all",
			-- 			},
			-- 		},
			-- 	},
			-- })

			lspconfig.solargraph.setup({
				capabilities = capabilities,
			})

			lspconfig.html.setup({
				capabilities = capabilities,
			})

			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = {
							-- Get the language server to recognize the `vim` global
							globals = { "vim" },
						},
					},
				},
			})

			lspconfig.tailwindcss.setup({
				capabilities = capabilities,
				filetypes = {
					"html",
					"css",
					"javascript",
					"javascriptreact",
					"typescriptreact",
					"vue",
					"astro",
					"svelte",
				},
				root_dir = lspconfig.util.root_pattern(
					"tailwind.config.js",
					"tailwind.config.ts",
					"postcss.config.js",
					"package.json"
				),
				settings = {
					tailwindCSS = {
						experimental = {
							classRegex = "tw`([^`]*)`",
						},
					},
				},
			})

			lspconfig.gopls.setup({
				capabilities = capabilities,
				settings = {
					gopls = {
						analyses = {
							unusedparams = true,
						},
						staticcheck = true,
					},
				},
			})

			lspconfig.typos_lsp.setup({
				filetypes = { "*" }, -- This applies typos-lsp to all file types
				settings = {
					typos = {
						language = "en", -- Specify the language to check, e.g., 'en' for English
					},
				},
			})
			lspconfig.yamlls.setup({
				capabilities = capabilities,
			})

			lspconfig.yamlls.setup({
				capabilities = capabilities,
			})

			lspconfig.dockerls.setup({
				capabilities = capabilities,
			})

			lspconfig.csharp_ls.setup({
				capabilities = capabilities,
			})

			lspconfig.jsonls.setup({
				capabilities = capabilities,
			})

			map("n", "K", vim.lsp.buf.hover, { desc = "Hover To Show Description" })
			map("n", "gd", vim.lsp.buf.definition, { desc = "Go To Definition" })
			map("n", "gr", vim.lsp.buf.references, { desc = "Go To References" })
			map("n", "ca", vim.lsp.buf.code_action, { desc = "Code Action" })
			map("n", "gi", vim.lsp.buf.implementation, { desc = "Go To Implementation" })
			map("n", "<leader>ra", vim.lsp.buf.rename, { desc = "Rename Variable" })
			map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "LSP Diagnostic" })
			map("n", "<leader>dw", function()
				vim.diagnostic.setqflist({ open = true }) -- Add all workspace diagnostics to the quickfix list
			end, { desc = "Show workspace diagnostics" })
		end,
	},
}
