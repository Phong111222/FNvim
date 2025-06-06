local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.cmd("set rnu!")
vim.cmd("set cmdheight=0")
vim.opt.fillchars:append({ eob = " " })

vim.opt.rtp:prepend(lazypath)
vim.g.loaded_matchparen = 0 -- disable built-in MatchParen.
vim.opt.cursorline = true

if vim.fn.has("unnamedplus") == 1 then
	vim.opt.clipboard = "unnamedplus"
else
	vim.opt.clipboard = "unnamed"
end

require("terminal")
require("floating-terminal")
require("vim-options")
require("autocmd")
require("mapping").setup()
require("lazy").setup("plugins")
