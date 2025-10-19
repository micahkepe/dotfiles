return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    config = function()
      -- Custom parsers
      --   See: https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#adding-parsers
      local parser_config = require "nvim-treesitter.parsers"
      -- Strudel
      parser_config.strudel = {
        install_info = {
          url = "https://github.com/pedrozappa/tree-sitter-strdl",
          files = { "src/parser.c" },
          -- optional entries:
          branch = "main",
          generate_requires_npm = false,
          requires_generate_from_grammar = false,
        },
        filetype = "strudel", -- if filetype does not match the parser namen
      }

      require("nvim-treesitter.configs").setup {
        highlight = {
          enable = true,

          -- disable highlighting from treesitter on large files
          disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats =
              pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
        },
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
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = false,
            node_decremental = "<bs>",
          },
        },
      }
    end,
  },
}
