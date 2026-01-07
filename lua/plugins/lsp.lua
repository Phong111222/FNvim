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
          "cssls",
          "lua_ls",
          "ts_ls",
          "tailwindcss",
          "yamlls",
          "dockerls",
          "csharp_ls",
          "pyright",
          "terraformls",
        },
        automatic_installation = true,
      })

      -- Install formatters
      local mason_registry = require("mason-registry")
      local formatters = { "black", "isort", "prettierd", "prettier", "stylua" }

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
        "cssls",
        "gopls",
        "typos_lsp",
        "html",
        "yamlls",
        "dockerls",
        "csharp_ls",
        "jsonls",
        "solargraph",
        "terraformls",
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
        { name = "DiagnosticSignWarn",  text = "" },
        { name = "DiagnosticSignHint",  text = "" },
        { name = "DiagnosticSignInfo",  text = "" },
      }

      for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
      end

      -- Override code lens display to customize the text
      local codelens_ns = vim.api.nvim_create_namespace("custom_codelens")

      -- Store original display handler
      local original_codelens_display = vim.lsp.codelens.display

      -- Custom display that filters unresolved text
      vim.lsp.codelens.display = function(lenses, bufnr, client_id)
        -- Filter out lenses that haven't resolved yet
        local resolved_lenses = {}
        for _, lens in ipairs(lenses or {}) do
          -- Only show lenses that have a command (meaning they're resolved)
          if lens.command and lens.command.title then
            -- Customize the display text here if needed
            local title = lens.command.title
            -- Only show if it contains actual reference count (not "unresolved")
            if not title:match("unresolved") and not title:match("Unresolved") then
              table.insert(resolved_lenses, lens)
            end
          end
        end

        -- Only display if we have resolved lenses
        if #resolved_lenses > 0 then
          original_codelens_display(resolved_lenses, bufnr, client_id)
        end
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

          -- Enable code lens (reference counts) by default
          if client.supports_method("textDocument/codeLens") then
            -- Initial refresh with delay to allow LSP to be ready
            vim.defer_fn(function()
              if vim.api.nvim_buf_is_valid(args.buf) then
                vim.lsp.codelens.refresh({ bufnr = args.buf })
              end
            end, 1000)

            -- Auto-refresh code lens on buffer events
            vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave", "CursorHold" }, {
              buffer = args.buf,
              group = vim.api.nvim_create_augroup("LspCodeLens_" .. args.buf, { clear = true }),
              callback = function()
                vim.lsp.codelens.refresh({ bufnr = args.buf })
              end,
              desc = "Refresh code lens (filtered)",
            })
          end
        end,
      })

      -- LSP keybindings (keeping your custom bindings + new Neovim 0.11 defaults)
      -- Your custom keybindings
      map("n", "K", vim.lsp.buf.hover, { desc = "Hover To Show Description" })
      map("n", "gd", vim.lsp.buf.definition, { desc = "Go To Definition" })
      map("n", "gr", function()
        require("telescope.builtin").lsp_references()
      end, { desc = "Go To References (Telescope)" })
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

      -- Inlay hints toggle keybinding
      map("n", "<leader>ih", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end, { desc = "Toggle Inlay Hints" })

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
