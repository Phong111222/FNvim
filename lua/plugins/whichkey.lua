return {
	"folke/which-key.nvim",
	config = function(_, otps)
		local wk = require("which-key")
		wk.add({

			{ "<leader>f", group = "File" }, -- group
			{ "<leader>fn", desc = "New File", group = "File" },
			{ "<leader>f1", hidden = true }, -- hide this keymap
			{ "<leader>w", proxy = "<c-w>", group = "windows" }, -- proxy to window mappings
			{
				"<leader>b",
				group = "buffers",
				expand = function()
					return require("which-key.extras").expand.buf()
				end,
			},
			{
				-- Nested mappings are allowed and can be added in any order
				-- Most attributes can be inherited or overridden on any level
				-- There's no limit to the depth of nesting
				mode = { "n", "v" }, -- NORMAL and VISUAL mode

				{ "<leader>x", "<cmd>q<cr>", desc = "Quit" }, -- no need to specify mode since it's inherited
				{ "<C-s>", "<cmd>w<cr>", desc = "Write" },
			},
		})
	end,
}
