return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- format on save
    config = function()
      require "configs.conform"
    end,
  },

  -- LSP and completion
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },

  -- Easy LSP installation and management
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

  -- treesitter for better syntax highlighting
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

  -- Markdown preview
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

  -- Git displays (diffs, signs, etc)
  { "tpope/vim-fugitive", cmd = { "Git" } },

  -- Neovim async functions in lua
  { "nvim-lua/plenary.nvim" },

  -- Popup windows
  { "nvim-lua/popup.nvim" },

  -- Golang support
  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },

  -- debuggers
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap", -- DAP client
      "nvim-neotest/nvim-nio",
    },
    config = function()
      require "configs.dap"
    end,
  },

  -- for better visuals on debugger UI
  { "theHamsta/nvim-dap-virtual-text" },

  -- Notification manager
  { "rcarriga/nvim-notify" },

  -- Highlighting tags like TODO, FIX, NOTE etc.
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" }, -- Load on buffer read
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("todo-comments").setup {}
    end,
  },

  -- Better quickfix window
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    config = function()
      require("bqf").setup()
    end,
  },

  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<C-h>", "<cmd><C-U>TmuxNavigateLeft<cr>", desc = "Navigate left" },
      { "<C-j>", "<cmd><C-U>TmuxNavigateDown<cr>", desc = "Navigate down" },
      { "<C-k>", "<cmd><C-U>TmuxNavigateUp<cr>", desc = "Navigate up" },
      { "<C-l>", "<cmd><C-U>TmuxNavigateRight<cr>", desc = "Navigate right" },
      { "<C-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>", desc = "Navigate previous" },
    },
  },

  -- Better looking input boxes
  { "stevearc/dressing.nvim", event = "VeryLazy" },

  -- Split maximizer
  {
    "szw/vim-maximizer",
    keys = {
      { "<leader>sm", "<cmd>MaximizerToggle<CR>", desc = "Maximize/minimize a split" },
    },
  },

  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },

  { "mbbill/undotree", lazy = true, cmd = "UndotreeToggle" }, -- see undo tree

  -- Image drag and drop
  -- For Mac: requires `pngpaste` (brew install pngpaste)
  {
    "HakonHarnes/img-clip.nvim",
    event = "VeryLazy",
    opts = {
      -- add options here
      -- or leave it empty to use the default settings
    },
    keys = {
      -- suggested keymap
      { "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
    },
  },

  -- Auto save when leaving INSERT mode
  {
    "pocco81/auto-save.nvim",
    lazy = false,
    config = function()
      require("auto-save").setup {}
    end,
  },

  -- LaTeX editing in the terminal
  {
    "lervag/vimtex",
    lazy = false,
    init = function()
      require "configs.vimtex"
    end,
  },

  -- Rust setup
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    lazy = false,
  },

  {
    "L3MON4D3/LuaSnip",
    dependencies = "rafamadriz/friendly-snippets",
    opts = { history = true, updateevents = "TextChanged,TextChangedI" },
    config = function(_, opts)
      require("luasnip").config.set_config(opts)
      require "nvchad.configs.luasnip"

      -- Load custom LaTeX snippets
      require("luasnip.loaders.from_lua").lazy_load { paths = "~/.config/nvim/lua/snippets/" }
    end,
  },

  -- PlantUML syntax highlighting + preview
  {
    "weirongxu/plantuml-previewer.vim",
    dependencies = {
      "tyru/open-browser.vim",
      "aklt/plantuml-syntax",
    },
    ft = "plantuml",
    lazy = false,
  },

  {
    "ravibrock/regisfilter.nvim",
    lazy = false,
    opts = {
      global_patterns = {
        "%^s*$", -- whitespace
        "^[ \t]*\n", -- whitespace with newline or tabs
        "^.$", -- single character
      }, -- List of patterns to match for everything
      register_patterns = {}, -- List of patterns to match for specific registers
      ft_patterns = {}, -- List of patterns to match for specific filetypes
      negative_match = true, -- Don't send to register if the pattern is matched
      registers = { '"', "1", "-" }, -- List of registers to monitor (only need "1" for 1-9)
      system_clipboard = "", -- Use the system clipboard (updates to vim.opt.clipboard if not empty)
      remap_paste = true, -- Remap p and P to sync with clipboard settings
    },
  },

  {
    "micahkepe/merge.nvim",
    lazy = false,
    config = function()
      require("merge").setup {}
    end,
  },
}
