return {
	"VidocqH/lsp-lens.nvim",
	event = "LspAttach",
	opts = {
		include_declaration = false,
		sections = {
			definition = false,
			references = true,
			implements = false,
		},
	},
}
