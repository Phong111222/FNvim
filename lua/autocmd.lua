-- autocmds (smooth-cursor removed — now using smear-cursor.nvim)

-- Transparent background for floating windows (terminal, telescope, etc.)
local function set_transparent_float_hl()
	local fb = vim.api.nvim_get_hl(0, { name = "FloatBorder" })
	local border_hl = { fg = fb.fg, bg = "NONE" }

	vim.api.nvim_set_hl(0, "FloatTermBorder", border_hl)
	vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
	vim.api.nvim_set_hl(0, "FloatBorder", border_hl)
	vim.api.nvim_set_hl(0, "FloatTitle", border_hl)

	vim.api.nvim_set_hl(0, "TelescopeNormal", { link = "Normal" })
	vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { link = "Normal" })
	vim.api.nvim_set_hl(0, "TelescopePromptNormal", { link = "Normal" })
	vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { link = "Normal" })
	vim.api.nvim_set_hl(0, "TelescopeBorder", border_hl)
	vim.api.nvim_set_hl(0, "TelescopePreviewBorder", border_hl)
	vim.api.nvim_set_hl(0, "TelescopePromptBorder", border_hl)
	vim.api.nvim_set_hl(0, "TelescopeResultsBorder", border_hl)
	vim.api.nvim_set_hl(0, "TelescopeTitle", border_hl)
	vim.api.nvim_set_hl(0, "TelescopePreviewTitle", border_hl)
	vim.api.nvim_set_hl(0, "TelescopePromptTitle", border_hl)
	vim.api.nvim_set_hl(0, "TelescopeResultsTitle", border_hl)
end
set_transparent_float_hl()
vim.api.nvim_create_autocmd("ColorScheme", {
	callback = set_transparent_float_hl,
})
