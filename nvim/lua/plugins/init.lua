return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- format on save
    config = function()
      require "configs.conform"
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "html-lsp",
        "css-lsp",
        "prettier",
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
      },
    },
  },

  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    config = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
  },

  -- Custom Copilot plugin for better compatibility with NVChad
  { require "plugins.copilot" },

  -- Add wilder.nvim plugin and load the configuration
  {
    "gelguy/wilder.nvim",
    build = ":UpdateRemotePlugins",
    config = function()
      require "plugins.wilder"
    end,
  },
  -- Add yarp and vim-hug-neovim-rpc for Vim if needed
  {
    "roxma/nvim-yarp",
    cond = function()
      return not vim.fn.has "nvim"
    end,
  },
  {
    "roxma/vim-hug-neovim-rpc",
    cond = function()
      return not vim.fn.has "nvim"
    end,
  },

  { "tpope/vim-fugitive" },
}
