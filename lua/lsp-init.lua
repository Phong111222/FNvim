local lspArr = {
	"lua_ls",
	"ts_ls",
	"csharp_ls",
	"omnisharp",
	"tailwindcss",
	"cssls",
	"jsonls",
	"eslint",
	"typos_lsp",
	"html",
	"yamlls",
	"dockerls",
	"pyright",
	"terraformls",
}

vim.diagnostic.config({
	virtual_text = {},
})

for _, lsp in ipairs(lspArr) do
	vim.lsp.enable(lsp)
end
