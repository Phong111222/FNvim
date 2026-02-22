-- ESLint LSP configuration
-- Provides linting and formatting according to ESLint rules
return {
	settings = {
		-- Validate JS, TS, JSX, TSX, Vue, Svelte
		validate = "on",
		packageManager = "npm",
		useESLintClass = false,
		-- Let conform handle formatting, ESLint provides code actions
		codeAction = {
			disableRuleComment = {
				enable = true,
				location = "separateLine",
			},
			showDocumentation = {
				enable = true,
			},
		},
		-- ESLint provides diagnostics, not formatting
		format = false,
		quiet = false,
		onIgnoredFiles = "off",
		rulesCustomizations = {},
		run = "onType",
		problems = {
			shortenToSingleLine = false,
		},
		-- Enable for more file types
		workingDirectories = { mode = "auto" },
	},
}
