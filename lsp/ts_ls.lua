-- TypeScript/JavaScript LSP configuration (native ts_ls)
-- ESLint is configured separately and will provide linting
return {
  -- ts_ls handles type checking and language features
  -- ESLint handles code style and linting rules
  on_attach = function(client, bufnr)
    -- Enable inlay hints for TypeScript/JavaScript
    if client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end
  end,
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayFunctionParameterTypeHints = true,
        -- includeInlayPropertyDeclarationTypeHints = true,
        -- includeInlayVariableTypeHints = true,
        -- includeInlayFunctionLikeReturnTypeHints = true,
        -- includeInlayEnumMemberValueHints = true,
      },
      -- Disable ts_ls formatting in favor of ESLint/Prettier
      format = {
        enable = false,
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",

        includeInlayFunctionParameterTypeHints = true,
        -- includeInlayVariableTypeHints = true,
        -- includeInlayPropertyDeclarationTypeHints = true,
        -- includeInlayFunctionLikeReturnTypeHints = true,
        -- includeInlayEnumMemberValueHints = true,
      },
      -- Disable js formatting in favor of ESLint/Prettier
      format = {
        enable = false,
      },
    },
  },
}
