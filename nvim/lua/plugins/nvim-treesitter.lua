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
        "bash",
        "c",
        "css",
        "dockerfile",
        "gitignore",
        "go",
        "gomod",
        "haskell",
        "html",
        "java",
        "javascript",
        "json",
        "latex",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "rust",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "wgsl",
        "yaml",
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
