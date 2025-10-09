-- Go LSP configuration
return {
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
}
