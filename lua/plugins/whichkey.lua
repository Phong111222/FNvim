return {
	"folke/which-key.nvim",
	config = function()
		local wk = require("which-key")
		wk.add({

			{ "<leader>f", group = "File" }, -- group
			{ "<leader>fn", desc = "New File", group = "File" },
			{ "<leader>f1", hidden = true }, -- hide this keymap
			{ "<leader>w", proxy = "<c-w>", group = "windows" }, -- proxy to window mappings
			{
				-- Nested mappings are allowed and can be added in any order
				-- Most attributes can be inherited or overridden on any level
				-- There's no limit to the depth of nesting
				mode = { "n", "v" }, -- NORMAL and VISUAL mode

				{ "<C-s>", "<cmd>w<cr>", desc = "Write" },
			},
		})
	end,
}
