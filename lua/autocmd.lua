-- autocmds (smooth-cursor removed — now using smear-cursor.nvim)

-- Transparent background for floating windows (terminal, telescope, etc.)
local function set_transparent_float_hl()
	local fb = vim.api.nvim_get_hl(0, { name = "FloatBorder" })
	vim.api.nvim_set_hl(0, "FloatTermBorder", { fg = fb.fg, bg = nil })
	vim.api.nvim_set_hl(0, "TelescopeNormal", { link = "Normal" })
	vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { link = "Normal" })
	vim.api.nvim_set_hl(0, "TelescopePromptNormal", { link = "Normal" })
	vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { link = "Normal" })
	vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = fb.fg, bg = nil })
	vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { fg = fb.fg, bg = nil })
	vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = fb.fg, bg = nil })
	vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { fg = fb.fg, bg = nil })
end
set_transparent_float_hl()
vim.api.nvim_create_autocmd("ColorScheme", {
	callback = set_transparent_float_hl,
})
