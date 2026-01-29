return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    config = function()
      -- Custom parsers
      --   See: https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#adding-parsers
      local parser_config = require "nvim-treesitter.parsers"
      parser_config.strudel = {
        install_info = {
          url = "https://github.com/pedrozappa/tree-sitter-strdl",
          files = { "src/parser.c" },
          branch = "main",
          generate_requires_npm = false,
          requires_generate_from_grammar = false,
        },
        filetype = "strudel",
      }
    end,
    opts = {
      ensure_installed = {
        "json",
        "javascript",
        "typescript",
        "tsx",
        "yaml",
        "html",
        "css",
        "prisma",
        "markdown",
        "markdown_inline",
        "svelte",
        "graphql",
        "bash",
        "lua",
        "vim",
        "dockerfile",
        "gitignore",
        "query",
        "vimdoc",
        "c",
        "rust",
      },
    },
  },
}
