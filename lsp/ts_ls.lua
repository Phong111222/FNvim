-- TypeScript/JavaScript LSP configuration (native ts_ls)
-- ESLint is configured separately and will provide linting
return {
  -- ts_ls handles type checking and language features
  -- ESLint handles code style and linting rules
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
      -- Disable ts_ls formatting in favor of ESLint/Prettier
      format = {
        enable = false,
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
      -- Disable js formatting in favor of ESLint/Prettier
      format = {
        enable = false,
      },
    },
  },
}
