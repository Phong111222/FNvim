---@type vim.lsp.Config
return {
  root_dir = function(bufnr, on_dir)
    local root = vim.fs.root(bufnr, { "tsconfig.json", "jsconfig.json" })
      or vim.fs.root(bufnr, { "package.json", ".git" })
    if root then
      on_dir(root)
    end
  end,
  settings = {
    vtsls = {
      autoUseWorkspaceTsdk = true,
      experimental = {
        completion = {
          enableServerSideFuzzyMatch = true,
        },
      },
    },
    typescript = {
      preferences = {
        includePackageJsonAutoImports = "off",
      },
      tsserver = {
        maxTsServerMemory = 4096,
      },
    },
  },
}
