-- TailwindCSS LSP configuration
return {
  filetypes = {
    "html",
    "css",
    "javascript",
    "javascriptreact",
    "typescriptreact",
    "vue",
    "astro",
    "svelte",
  },
  root_dir = function(fname)
    local util = require('lspconfig.util')
    return util.root_pattern(
      "tailwind.config.js",
      "tailwind.config.ts",
      "postcss.config.js",
      "package.json"
    )(fname)
  end,
  settings = {
    tailwindCSS = {
      experimental = {
        classRegex = "tw`([^`]*)`",
      },
    },
  },
}
