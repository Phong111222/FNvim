-- TypeScript/JavaScript LSP configuration (native ts_ls)
-- ESLint is configured separately and will provide linting
return {
  -- ts_ls handles type checking and language features
  -- ESLint handles code style and linting rules
  on_attach = function(client, bufnr)
    -- Inlay hints are disabled by default (toggle with <leader>ih)
    if client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
    end
  end,
  settings = {
    typescript = {
      -- Enable code lens for reference counts
      referencesCodeLens = {
        enabled = true,
        showOnAllFunctions = true,
      },
      implementationsCodeLens = {
        enabled = true,
      },
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
      -- Enable code lens for reference counts
      referencesCodeLens = {
        enabled = true,
        showOnAllFunctions = true,
      },
      implementationsCodeLens = {
        enabled = true,
      },
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
