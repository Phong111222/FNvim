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
          "tailwindcss",
          "typos_lsp",
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
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  },

  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local lspconfig = require("lspconfig")

      lspconfig.eslint.setup({
        capabilities = capabilities,
        settings = {
          validate = { "javascript", "typescript" }, -- Enable for JS and TS files
          lint = {
            enable = true,                           -- Enable linting
          },
        },
      })

      require("typescript-tools").setup({
        settings = {
          tsserver_file_preferences = {
            -- includeInlayParameterNameHints = "all",
            -- includeCompletionsForModuleExports = true,
            quotePreference = "auto",
          },
          tsserver_plugins = {
            -- for TypeScript v4.9+
            "@styled/typescript-styled-plugin",
            -- or for older TypeScript versions
            -- "typescript-styled-plugin",
          },
          tsserver_format_options = {
            allowIncompleteCompletions = false,
            allowRenameOfImportPath = false,
          },
        },
      })

      -- lspconfig.ts_ls.setup({
      -- 	capabilities = capabilities,
      -- 	settings = {
      -- 		typescript = {
      -- 			inlayHints = {
      -- 				includeInlayParameterNameHints = "all",
      -- 			},
      -- 		},
      -- 		javascript = {
      -- 			inlayHints = {
      -- 				includeInlayParameterNameHints = "all",
      -- 			},
      -- 		},
      -- 	},
      -- })

      lspconfig.solargraph.setup({
        capabilities = capabilities,
      })

      lspconfig.html.setup({
        capabilities = capabilities,
      })

      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            runtime = {
              -- Tell the language server which version of Lua you're using
              version = 'LuaJIT',
            },
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = { 'vim' },
            },
            workspace = {
              -- Make the server aware of Neovim runtime files
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false, -- Disable third-party checking
            },
            telemetry = {
              enable = false,
            },
          },
        },
      })

      lspconfig.tailwindcss.setup({
        capabilities = capabilities,
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
        root_dir = lspconfig.util.root_pattern(
          "tailwind.config.js",
          "tailwind.config.ts",
          "postcss.config.js",
          "package.json"
        ),
        settings = {
          tailwindCSS = {
            experimental = {
              classRegex = "tw`([^`]*)`",
            },
          },
        },
      })

      lspconfig.gopls.setup({
        capabilities = capabilities,
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
            },
            staticcheck = true,
          },
        },
      })

      lspconfig.typos_lsp.setup({
        filetypes = { "*" }, -- This applies typos-lsp to all file types
        settings = {
          typos = {
            language = "en", -- Specify the language to check, e.g., 'en' for English
          },
        },
      })
      lspconfig.yamlls.setup({
        capabilities = capabilities,
      })

      lspconfig.yamlls.setup({
        capabilities = capabilities,
      })

      lspconfig.dockerls.setup({
        capabilities = capabilities,
      })

      lspconfig.csharp_ls.setup({
        capabilities = capabilities,
      })

      lspconfig.jsonls.setup({
        capabilities = capabilities,
      })

      -- Function to find Python interpreter
      local function get_python_path(workspace)
        -- First check if pyrightconfig.json exists and use it
        local pyright_config = workspace .. "/pyrightconfig.json"
        if vim.fn.filereadable(pyright_config) == 1 then
          local ok, config = pcall(vim.fn.json_decode, vim.fn.readfile(pyright_config))
          if ok and config.pythonPath then
            local python_path = config.pythonPath
            if not vim.startswith(python_path, "/") then
              python_path = workspace .. "/" .. python_path
            end
            if vim.fn.filereadable(python_path) == 1 then
              return python_path
            end
          end
        end

        -- Check for common virtual environment patterns
        local venv_paths = {
          workspace .. "/lc-academy-env/bin/python",
          workspace .. "/.venv/bin/python",
          workspace .. "/venv/bin/python",
          workspace .. "/env/bin/python",
        }

        for _, path in ipairs(venv_paths) do
          if vim.fn.filereadable(path) == 1 then
            return path
          end
        end

        -- Check for Poetry
        if vim.fn.executable("poetry") == 1 then
          local handle = io.popen("cd " .. vim.fn.shellescape(workspace) .. " && poetry env info -p 2>/dev/null")
          if handle then
            local poetry_env = handle:read("*a"):gsub("%s+$", "")
            handle:close()
            if poetry_env and poetry_env ~= "" then
              local poetry_python = poetry_env .. "/bin/python"
              if vim.fn.filereadable(poetry_python) == 1 then
                return poetry_python
              end
            end
          end
        end

        -- Check for Pipenv
        if vim.fn.executable("pipenv") == 1 then
          local handle = io.popen("cd " .. vim.fn.shellescape(workspace) .. " && pipenv --py 2>/dev/null")
          if handle then
            local pipenv_python = handle:read("*a"):gsub("%s+$", "")
            handle:close()
            if pipenv_python and pipenv_python ~= "" and vim.fn.filereadable(pipenv_python) == 1 then
              return pipenv_python
            end
          end
        end

        -- Check for Conda
        if os.getenv("CONDA_PREFIX") then
          local conda_python = os.getenv("CONDA_PREFIX") .. "/bin/python"
          if vim.fn.filereadable(conda_python) == 1 then
            return conda_python
          end
        end

        -- Fall back to system Python
        return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
      end

      lspconfig.pyright.setup({
        capabilities = capabilities,
        root_dir = lspconfig.util.root_pattern("pyrightconfig.json", "pyproject.toml", "setup.py", ".git"),
        on_new_config = function(new_config, new_root_dir)
          local python_path = get_python_path(new_root_dir)
          new_config.settings = new_config.settings or {}
          new_config.settings.python = new_config.settings.python or {}
          new_config.settings.python.pythonPath = python_path
        end,
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic",
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "workspace",
              autoImportCompletions = true,
            },
          },
        },
      })

      lspconfig.jsonls.setup({
        capabilities = capabilities,
      })

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
    end,
  },
}
