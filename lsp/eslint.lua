-- ESLint LSP configuration
-- Provides linting and formatting according to ESLint rules
return {
  on_attach = function(client, bufnr)
    -- Enable auto-fix on save (only for JS/TS files with ESLint config)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        -- Check if EslintFixAll command is available
        if vim.fn.exists(":EslintFixAll") > 0 then
          vim.cmd("EslintFixAll")
        end
      end,
    })
  end,
  settings = {
    -- Validate JS, TS, JSX, TSX, Vue, Svelte
    validate = "on",
    packageManager = "npm",
    useESLintClass = false,
    codeActionOnSave = {
      enable = true,
      mode = "all",
    },
    format = true,
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
