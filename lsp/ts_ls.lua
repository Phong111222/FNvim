-- TypeScript/JavaScript LSP configuration (native ts_ls)
-- Note: typescript-tools.nvim is also configured as an alternative
return {
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
    },
  },
}
