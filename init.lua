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

require("vim-options")
require("mapping").setup()
require("lazy").setup("plugins")
