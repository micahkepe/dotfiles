return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    init = function()
      -- Custom parsers must be registered before TSUpdate fires
      vim.api.nvim_create_autocmd("User", {
        pattern = "TSUpdate",
        callback = function()
          require("nvim-treesitter.parsers").strudel = {
            tier = 2,
            install_info = {
              url = "https://github.com/pedrozappa/tree-sitter-strdl",
              branch = "main",
              generate = false,
            },
          }
        end,
      })
      vim.treesitter.language.register("strudel", { "strudel" })
    end,
    config = function()
      require("nvim-treesitter").setup()

      local ensure_installed = {
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
      }
      local installed = require("nvim-treesitter.config").get_installed()
      local missing = vim.tbl_filter(function(p)
        return not vim.tbl_contains(installed, p)
      end, ensure_installed)
      if #missing > 0 then
        require("nvim-treesitter").install(missing)
      end
    end,
  },
}
