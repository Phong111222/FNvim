local map = vim.eymap.set

local lspArr = {
	"lua_ls",
	"ts_ls",
	"csharp_ls",
	"tailwindcss",
	"cssls",
	"jsonls",
	"eslint",
	"typos_lsp",
	"html",
	"yamlls",
	"docerls",
	"pyright",
	"terraformls",
}

for _, lsp in ipairs(lspArr) do
	vim.lsp.enable(lsp)
end
