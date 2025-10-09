local map = vim.keymap.set
return {
  {
    "williamboman/mason.nvim",
    config = function()
      local mason = require("mason")
      mason.setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "eslint",
          "typos_lsp",
          "html",
          "lua_ls",
          "ts_ls",
          "tailwindcss",
          "yamlls",
          "dockerls",
          "csharp_ls",
          "pyright",
        },
        automatic_installation = true,
      })

      -- Install Python formatters
      local mason_registry = require("mason-registry")
      local formatters = { "black", "isort" }

      for _, formatter in ipairs(formatters) do
        if not mason_registry.is_installed(formatter) then
          mason_registry.get_package(formatter):install()
        end
      end
    end,
  },

  {
    "antosha417/nvim-lsp-file-operations",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- Uncomment whichever supported plugin(s) you use
      -- "nvim-tree/nvim-tree.lua",
      -- "nvim-neo-tree/neo-tree.nvim",
      -- "simonmclean/triptych.nvim"
    },
    config = function()
      require("lsp-file-operations").setup()
    end,
  },
  -- {
  --   "MysticalDevil/inlay-hints.nvim",
  --   event = "LspAttach",
  --   dependencies = { "neovim/nvim-lspconfig" },
  --   config = function()
  --     require("inlay-hints").setup()
  --   end,
  -- },
  -- TypeScript tools disabled in favor of native ts_ls
  -- {
  --   "pmizio/typescript-tools.nvim",
  --   dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  --   config = function()
  --     require("typescript-tools").setup({
  --       settings = {
  --         tsserver_file_preferences = {
  --           quotePreference = "auto",
  --         },
  --         tsserver_plugins = {
  --           "@styled/typescript-styled-plugin",
  --         },
  --         tsserver_format_options = {
  --           allowIncompleteCompletions = false,
  --           allowRenameOfImportPath = false,
  --         },
  --       },
  --     })
  --   end,
  -- },

  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      -- Native LSP configuration using Neovim 0.11+ APIs
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- List of LSP servers to enable (configs are in ~/.config/nvim/lsp/)
      local servers = {
        "lua_ls",
        "pyright",
        "ts_ls", -- Native TypeScript/JavaScript LSP (alternative to typescript-tools)
        "eslint",
        "tailwindcss",
        "gopls",
        "typos_lsp",
        "html",
        "yamlls",
        "dockerls",
        "csharp_ls",
        "jsonls",
        "solargraph",
      }

      -- Register all LSP configs using vim.lsp.config()
      for _, server_name in ipairs(servers) do
        local config_path = vim.fn.stdpath("config") .. "/lsp/" .. server_name .. ".lua"
        local ok, server_config = pcall(dofile, config_path)

        if ok then
          -- Merge capabilities into the config
          server_config.capabilities = capabilities

          -- Register the config with vim.lsp.config()
          vim.lsp.config(server_name, server_config)

          -- Enable the server using vim.lsp.enable()
          vim.lsp.enable(server_name)
        else
          vim.notify("Failed to load LSP config for " .. server_name, vim.log.levels.WARN)
        end
      end

      -- Configure diagnostics to show inline like Error Lens
      vim.diagnostic.config({
        virtual_text = {
          prefix = "●",
          source = "if_many", -- Show source if multiple LSP servers
          spacing = 4,
          format = function(diagnostic)
            -- Format diagnostic message to show source and message
            if diagnostic.source then
              return string.format("[%s] %s", diagnostic.source, diagnostic.message)
            end
            return diagnostic.message
          end,
        },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      })

      -- Define diagnostic signs
      local signs = {
        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn", text = "" },
        { name = "DiagnosticSignHint", text = "" },
        { name = "DiagnosticSignInfo", text = "" },
      }

      for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
      end

      -- Enable native LSP completion when a client attaches
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client.supports_method("textDocument/completion") then
            vim.lsp.completion.enable(true, client.id, args.buf, {
              convert = function(item)
                -- Customize completion item transformation if needed
                return item
              end,
            })
          end
        end,
      })

      -- LSP keybindings (keeping your custom bindings + new Neovim 0.11 defaults)
      -- Your custom keybindings
      map("n", "K", vim.lsp.buf.hover, { desc = "Hover To Show Description" })
      map("n", "gd", vim.lsp.buf.definition, { desc = "Go To Definition" })
      map("n", "gr", vim.lsp.buf.references, { desc = "Go To References" })
      map("n", "ca", vim.lsp.buf.code_action, { desc = "Code Action" })
      map("n", "gi", vim.lsp.buf.implementation, { desc = "Go To Implementation" })
      map("n", "<leader>ra", vim.lsp.buf.rename, { desc = "Rename Variable" })
      map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "LSP Diagnostic" })
      map("n", "<leader>dw", function()
        vim.diagnostic.setqflist({ open = true }) -- Add all workspace diagnostics to the quickfix list
      end, { desc = "Show workspace diagnostics" })

      -- Neovim 0.11 default keybindings (alternative ways to access same features)
      map("n", "grn", vim.lsp.buf.rename, { desc = "LSP Rename (0.11 default)" })
      map("n", "grr", vim.lsp.buf.references, { desc = "LSP References (0.11 default)" })
      map("n", "gri", vim.lsp.buf.implementation, { desc = "LSP Implementation (0.11 default)" })
      map("n", "gra", vim.lsp.buf.code_action, { desc = "LSP Code Action (0.11 default)" })

      -- LSP folding support (new in 0.11) - disabled by default to avoid auto-folding
      -- Uncomment the lines below to enable LSP-based folding
      -- vim.opt.foldmethod = "expr"
      -- vim.opt.foldexpr = "v:lua.vim.lsp.foldexpr()"
      -- vim.opt.foldtext = "v:lua.vim.lsp.foldtext()"
      -- vim.opt.foldlevel = 99 -- Start with all folds open
      -- vim.opt.foldlevelstart = 99 -- Open all folds when opening a file
    end,
  },
}
