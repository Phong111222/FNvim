# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal Neovim configuration using Lazy.nvim as the plugin manager. The configuration is structured with modular Lua files and includes extensive LSP support, completion, formatting, and custom key mappings.

## Architecture

The configuration follows a modular structure:

- `init.lua` - Entry point that bootstraps Lazy.nvim and loads core modules
- `lua/vim-options.lua` - Basic vim settings (tabs, leader key, navigation)
- `lua/mapping.lua` - Custom key mappings and buffer management functions
- `lua/autocmd.lua` - Auto-commands for cursor styling based on vim modes
- `lua/terminal.lua` & `lua/floating-terminal.lua` - Terminal integration
- `lua/plugins/claude-code.lua` - Claude Code plugin configuration
- `lua/plugins/` - Individual plugin configurations

## Key Bindings

- Leader key: `<Space>`
- `<leader>cc` - Toggle Claude Code
- `<leader>cf` - Focus Claude Code
- `<leader>ar` - Resume Claude Code session
- `<leader>cC` - Continue Claude Code session
- `<leader>cb` - Add current buffer to Claude Code
- `<leader>cs` - Send selection to Claude Code (visual mode)
- `<leader>ca` - Accept Claude Code diff
- `<leader>cd` - Deny Claude Code diff
- `<leader>x` - Smart buffer close with save prompt
- `<leader>a` - Select all text
- `<leader>W` - Save without auto-formatting
- `jk` in insert mode - Escape to normal mode
- `<Esc><Esc>` in terminal - Exit terminal mode

## LSP Configuration

The LSP setup (lua/plugins/lsp.lua) includes servers for:
- TypeScript/JavaScript (typescript-tools.nvim, eslint)
- Lua (lua_ls with vim globals)
- HTML, CSS, TailwindCSS
- Go (gopls), C# (csharp_ls), Docker, YAML
- Ruby (solargraph)
- Typos checking (typos_lsp)

Key LSP mappings:
- `K` - Show hover documentation
- `gd` - Go to definition
- `gr` - Show references
- `ca` - Code actions
- `<leader>ra` - Rename symbol
- `<leader>ds` - Show diagnostics in location list

## Plugin Management

Uses Lazy.nvim for plugin management. Key plugins include:
- LSP: mason.nvim, nvim-lspconfig, typescript-tools
- Completion: nvim-cmp with LSP and snippet sources
- Git: gitsigns, lazygit (`<leader>lg`)
- UI: catppuccin theme, lualine, telescope
- Editing: treesitter, nvim-surround, autoclose
- Formatting: conform.nvim
- AI: copilot.lua, codecompanion.nvim, claudecode.nvim

## Development Workflow

1. Configuration changes are auto-loaded via Lazy.nvim
2. Plugin sync: `:Lazy sync`
3. LSP management: `:Mason` for server installation
4. Git operations: `<leader>lg` for LazyGit interface
5. File operations handle LSP-aware renaming via nvim-lsp-file-operations

## Claude Code Integration

The claudecode.nvim plugin provides seamless integration with Claude Code, offering features like:
- Toggle Claude Code interface (`<leader>cc`)
- Focus management (`<leader>cf`)
- Session resuming and continuation
- Buffer and selection sharing
- Diff management for code suggestions