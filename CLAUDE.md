# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal Neovim configuration using Lazy.nvim as the plugin manager. The configuration is structured with modular Lua files and includes extensive LSP support using Neovim 0.11.4's native LSP APIs, completion, formatting, and custom key mappings.

## Architecture

The configuration follows a modular structure:

- `init.lua` - Entry point that bootstraps Lazy.nvim and loads core modules
- `lua/vim-options.lua` - Basic vim settings (tabs, leader key, navigation)
- `lua/mapping.lua` - Custom key mappings and buffer management functions
- `lua/autocmd.lua` - Auto-commands for cursor styling based on vim modes
- `lua/terminal.lua` & `lua/floating-terminal.lua` - Terminal integration
- `lua/plugins/` - Individual plugin configurations
- `lsp/` - Modular LSP server configurations (Neovim 0.11+ native approach)

## Key Bindings

- Leader key: `<Space>`
- `<leader>x` - Smart buffer close with save prompt
- `<leader>a` - Select all text
- `<leader>H…` - herdr-nvim annotations (`Hc` comment, `Hl` list, `Hs` send, `HS` submit, `Hi` ref)
- `<leader>W` - Save without auto-formatting
- `jk` in insert mode - Escape to normal mode
- `<Esc><Esc>` in terminal - Exit terminal mode

## LSP Configuration

**Neovim 0.11.4 Native LSP Setup:**
This configuration uses Neovim's native `vim.lsp.config()` and `vim.lsp.enable()` APIs for a modern, streamlined LSP setup.

### LSP Servers (configured in `lsp/` directory):
- **TypeScript/JavaScript**: ts_ls (native) with full inlay hints + ESLint for linting
- **Python**: pyright with intelligent virtual environment detection (Poetry, Pipenv, Conda, venv)
- **Lua**: lua_ls with vim globals and Neovim runtime awareness
- **Go**: gopls with static analysis
- **Web**: html, tailwindcss (with custom filetypes)
- **Infrastructure**: terraformls, dockerls, yamlls, jsonls
- **Other**: csharp_ls, solargraph (Ruby), typos_lsp

### Key Features:
- **Native LSP completion**: Built-in completion with side effects (snippets, text edits)
- **Inline diagnostics**: Error Lens-style virtual text with source attribution
- **Inlay hints**: Type hints for TypeScript/JavaScript (toggle with `<leader>ih`)
- **ESLint integration**: Auto-fix on save for JS/TS files
- **Modular configs**: Each server configured in `lsp/<server>.lua`

### LSP Keybindings:

**Custom mappings:**
- `K` - Show hover documentation
- `gd` - Go to definition
- `gr` - Show references
- `ca` - Code actions
- `gi` - Go to implementation
- `<leader>ra` - Rename symbol
- `<leader>ds` - Show diagnostics in location list
- `<leader>dw` - Show workspace diagnostics
- `<leader>ih` - Toggle inlay hints

**Neovim 0.11 defaults (also available):**
- `grn` - Rename
- `grr` - References
- `gri` - Implementation
- `gra` - Code actions

## Plugin Management

Uses Lazy.nvim for plugin management. Key plugins include:
- **LSP**: mason.nvim (server installer), nvim-lspconfig (Neovim 0.11 native setup)
- **Completion**: nvim-cmp with LSP and snippet sources, native LSP completion
- **Git**: gitsigns, lazygit (`<leader>lg`)
- **UI**: catppuccin theme, lualine, telescope
- **Editing**: treesitter (syntax highlighting, indentation), nvim-surround, autoclose
- **Formatting**: conform.nvim
- **AI**: copilot.lua, codecompanion.nvim, herdr-nvim (annotations to Herdr agents, `<leader>H` prefix)

## Development Workflow

1. **Configuration changes** are auto-loaded via Lazy.nvim
2. **Plugin sync**: `:Lazy sync`
3. **LSP management**:
   - `:Mason` for server installation
   - `:LspInfo` to check attached servers
   - `:LspRestart <server>` to restart a specific server
4. **Git operations**: `<leader>lg` for LazyGit interface
5. **File operations** handle LSP-aware renaming via nvim-lsp-file-operations

## Treesitter Configuration

- **Auto-install**: Parsers install automatically when opening files
- **Parsers**: lua, luadoc, vim, vimdoc, typescript, javascript, html, vue, svelte, tsx, go, graphql, python
- **Features**: Syntax highlighting, indentation, auto-tag (HTML/JSX)
- **Update**: `:TSUpdate` to update all parsers
