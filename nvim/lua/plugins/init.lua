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
    "mason-org/mason.nvim",
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

  -- use treesitter to auto close and/or rename HTML tags
  {
    "windwp/nvim-ts-autotag",
    event = { "BufRead", "BufNewFile" },
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },

  -- Markdown preview
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    lazy = true,
    cmd = "MarkdownPreview",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    config = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
  },

  -- Git displays (diffs, signs, etc)
  { "tpope/vim-fugitive", lazy = true, cmd = { "Git" } },

  -- Neovim async functions in lua
  { "nvim-lua/plenary.nvim", lazy = true },

  -- Golang support
  {
    "ray-x/go.nvim",
    lazy = true,
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()
    end,
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },

  -- debuggers
  {
    "rcarriga/nvim-dap-ui",
    cmd = "DapToggleUI",
    lazy = true,
    dependencies = {
      "mfussenegger/nvim-dap", -- DAP client
      "nvim-neotest/nvim-nio",
    },
    config = function()
      require "configs.dap"
    end,
  },

  {
    "mason-org/mason.nvim",
    "mfussenegger/nvim-dap",
    "jay-babu/mason-nvim-dap.nvim",
  },

  -- for better visuals on debugger UI
  { "theHamsta/nvim-dap-virtual-text" },

  -- Highlighting tags like TODO, FIX, NOTE etc.
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" }, -- Load on buffer read
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("todo-comments").setup {}
    end,
  },

  -- Better QuickFix window
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
      {
        "<C-\\>",
        "<cmd><C-U>TmuxNavigatePrevious<cr>",
        desc = "Navigate previous",
      },
    },
  },

  {
    "echasnovski/mini.icons",
    opts = {},
    lazy = true,
    specs = {
      { "nvim-tree/nvim-web-devicons", enabled = false, optional = true },
    },
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },

  {
    "kylechui/nvim-surround",
    version = "*", -- latest version
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },

  { "mbbill/undotree", lazy = true, cmd = "UndotreeToggle" }, -- see undo tree

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
    ft = { "tex" },
    lazy = true,
    init = function()
      require "configs.vimtex"
    end,
  },

  -- Rust setup
  {
    "mrcjkb/rustaceanvim",
    version = "^6",
    ft = "rust",
  },

  {
    "L3MON4D3/LuaSnip",
    dependencies = "rafamadriz/friendly-snippets",
    opts = { history = true, updateevents = "TextChanged,TextChangedI" },
    config = function(_, opts)
      require("luasnip").config.set_config(opts)
      require "nvchad.configs.luasnip"

      -- Load custom LaTeX snippets
      require("luasnip.loaders.from_lua").lazy_load {
        paths = "~/.config/nvim/lua/snippets/",
      }
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
    cmd = "PlantUMLOpen",
    lazy = true,
  },

  {
    "ntpeters/vim-better-whitespace",
    event = "BufReadPre",
    lazy = true,
    config = function()
      vim.g.better_whitespace_enabled = 1
      vim.g.strip_whitespace_on_save = 0 -- LSP should handle on save
    end,
  },

  -- Kitty-like cursor trail
  {
    "sphamba/smear-cursor.nvim",
    event = "VeryLazy",
    opts = {
      -- Smear cursor when switching buffers or windows.
      smear_between_buffers = true,

      -- Smear cursor when moving within line or to neighbor lines.
      -- Use `min_horizontal_distance_smear` and `min_vertical_distance_smear` for finer control
      smear_between_neighbor_lines = true,

      -- Draw the smear in buffer space instead of screen space when scrolling
      scroll_buffer_space = true,

      -- Set to `true` if your font supports legacy computing symbols (block unicode symbols).
      -- Smears will blend better on all backgrounds.
      legacy_computing_symbols_support = false,

      -- Smear cursor in insert mode.
      -- See also `vertical_bar_cursor_insert_mode` and `distance_stop_animating_vertical_bar`.
      smear_insert_mode = true,
    },
  },

  {
    "lewis6991/gitsigns.nvim",
    opts = {
      sign_priority = 10, -- increased from default value so Harper doesn't interfere
    },
  },

  {
    "rust-lang/rust.vim",
  },

  -- Some semblance of Java support (just use IntelliJ)
  {
    "nvim-java/nvim-java",
  },

  {
    "micahkepe/todo.nvim",
    opts = {},
    cmd = "Todo",
    keys = {
      {
        "<leader>td",
        ":Todo<CR>",
        mode = "n",
        { desc = "Open Todos scratch file" },
      },
    },
  },
}
