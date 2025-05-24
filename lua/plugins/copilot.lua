return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		build = ":Copilot auth",
		event = "BufReadPost",
		opts = {
			suggestion = {
				enabled = not vim.g.ai_cmp,
				auto_trigger = true,
				hide_during_completion = vim.g.ai_cmp,
				keymap = {
					accept = "<Tab>", -- handled by nvim-cmp / blink.cmp
					next = "<M-]>",
					prev = "<M-[>",
				},
			},
			panel = { enabled = false },
			filetypes = {
				markdown = true,
				help = true,
			},
		},
	},
	{
		"olimorris/codecompanion.nvim",
		opts = {},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function(_, opts)
			local codeCompanion = require("codecompanion")
			codeCompanion.setup({
				adapters = {
					copilot = function()
						return require("codecompanion.adapters").extend("copilot", {
							schema = {
								model = {
									default = "claude-3.7-sonnet",
								},
							},
						})
					end,
				},
				display = {
					chat = {
						-- Change the default icons
						icons = {
							pinned_buffer = " ",
							watched_buffer = "👀 ",
						},

						-- Alter the sizing of the debug window
						debug_window = {
							---@return number|fun(): number
							width = vim.o.columns - 5,
							---@return number|fun(): number
							height = vim.o.lines - 2,
						},

						-- Options to customize the UI of the chat buffer
						window = {
							layout = "vertical", -- float|vertical|horizontal|buffer
							position = "right", -- left|right|top|bottom (nil will default depending on vim.opt.splitright|vim.opt.splitbelow)
							border = "single",
							height = 0.8,
							width = 0.3,
							relative = "editor",
							full_height = true, -- when set to false, vsplit will be used to open the chat buffer vs. botright/topleft vsplit
							opts = {
								breakindent = true,
								cursorcolumn = false,
								cursorline = false,
								foldcolumn = "0",
								linebreak = true,
								list = false,
								numberwidth = 1,
								signcolumn = "no",
								spell = false,
								wrap = true,
							},
						},

						---Customize how tokens are displayed
						---@param tokens number
						---@param adapter CodeCompanion.Adapter
						---@return string
						token_count = function(tokens, adapter)
							return " (" .. tokens .. " tokens)"
						end,
					},
				},
			})
		end,
	},
}
