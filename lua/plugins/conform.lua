return {
	"stevearc/conform.nvim",
	config = function()
		local conform = require("conform")

		local formatter = {
			lua = { "stylua" },
			-- For JS/TS: Use Prettier for formatting, ESLint provides linting only
			javascript = { "prettierd", "prettier", stop_after_first = true },
			typescript = { "prettierd", "prettier", stop_after_first = true },
			javascriptreact = { "prettierd", "prettier", stop_after_first = true },
			typescriptreact = { "prettierd", "prettier", stop_after_first = true },
			css = { "prettierd", "prettier", stop_after_first = true },
			scss = { "prettierd", "prettier", stop_after_first = true },
			less = { "prettierd", "prettier", stop_after_first = true },
			html = { "prettierd", "prettier", stop_after_first = true },
			json = { "prettierd", "prettier", stop_after_first = true },
			jsonc = { "prettierd", "prettier", stop_after_first = true },
			python = { "black", "isort" },
			terraform = { "terraform_fmt" },
			hcl = { "terraform_fmt" },
		}

		conform.setup({
			formatters_by_ft = formatter,
			format_on_save = function(bufnr)
				-- Disable format on save for files with LSP formatting conflicts
				if vim.bo[bufnr].filetype == "terraform" then
					return {
						timeout_ms = 2000,
						lsp_format = "never",
					}
				end
				return {
					timeout_ms = 1500, -- Optimized: prettierd is fast
					lsp_fallback = true, -- Use LSP formatting if conform fails
					async = true, -- Non-blocking for better UX
				}
			end,
			-- Notify on format errors
			notify_on_error = true,
		})

		-- Manual format command for debugging and visual mode
		vim.api.nvim_create_user_command("Format", function(args)
			local range = nil
			if args.count ~= -1 then
				local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
				range = {
					start = { args.line1, 0 },
					["end"] = { args.line2, end_line:len() },
				}
			end
			require("conform").format({ async = true, lsp_format = "fallback", range = range })
		end, { range = true })

		-- Keybinding for formatting in normal and visual mode
		vim.keymap.set("n", "<leader>fm", function()
			require("conform").format({ async = true, lsp_format = "fallback" })
		end, { desc = "Format buffer" })

		vim.keymap.set("v", "<leader>fm", function()
			require("conform").format({ async = true, lsp_format = "fallback" })
		end, { desc = "Format selection" })
	end,
}
