return {
	"catgoose/nvim-colorizer.lua",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		vim.opt.termguicolors = true

		require("colorizer").setup({
			filetypes = {
				"*",
				-- Avoid noisy matches in plain text/markdown
				"!markdown",
				"!text",
				css = { tailwind = true, css = true, css_fn = true },
				scss = { tailwind = true, css = true, css_fn = true },
				html = { tailwind = true, css = true },
				javascript = { tailwind = true },
				typescript = { tailwind = true },
				javascriptreact = { tailwind = true },
				typescriptreact = { tailwind = true },
				vue = { tailwind = true, css = true },
				svelte = { tailwind = true, css = true },
			},
			user_default_options = {
				RGB = true,        -- #RGB
				RRGGBB = true,     -- #RRGGBB
				RRGGBBAA = true,   -- #RRGGBBAA
				AARRGGBB = false,
				names = false,     -- "Blue" -- skip; too many false positives
				rgb_fn = true,     -- rgb()/rgba()
				hsl_fn = true,     -- hsl()/hsla()
				css = false,       -- enabled per-filetype above
				css_fn = false,    -- enabled per-filetype above
				tailwind = false,  -- enabled per-filetype above
				mode = "background",
				virtualtext = "■",
			},
		})
	end,
}
