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

-- Workaround for Neovim 0.12.1 bug: vim.lsp.document_color asserts on stale
-- client IDs (document_color.lua:225) when an LSP client is stopped while
-- buffers are still active (e.g. after :LspRestart or a server crash).
if vim.lsp.document_color and vim.lsp.document_color.enable then
	vim.lsp.document_color.enable(false)
end
