local lspArr = {
	"lua_ls",
	"vtsls",
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
	"basedpyright",
	"terraformls",
}

vim.diagnostic.config({
	virtual_text = {},
	float = { border = "rounded" },
})

for _, lsp in ipairs(lspArr) do
	vim.lsp.enable(lsp)
end

vim.lsp.enable("ts_ls", false)
