return {
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
  },
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",

    config = function()
      require("nvim-ts-autotag").setup()

      require("nvim-treesitter").install({
        "luadoc",
        "printf",
        "vim",
        "vimdoc",
        "typescript",
        "javascript",
        "html",
        "vue",
        "svelte",
        "tsx",
        "lua",
        "go",
        "graphql",
        "python",
        "json",
        "markdown",
        "markdown_inline",
      })

      -- Neovim 0.12: enable treesitter highlighting for all filetypes with a parser
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(ev)
          if vim.treesitter.language.add(ev.match) then
            vim.treesitter.start(ev.buf)
          end
        end,
      })
    end,
  },
}
