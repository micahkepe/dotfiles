---Disabled transitive plugins.
---@return table
local function disabled_plugins()
  local no_thanks =
    { "nvim-telescope/telescope.nvim", "nvim-tree/nvim-tree.lua" }
  local res = {}
  for _, plugin in ipairs(no_thanks) do
    res[#res + 1] = { plugin, enabled = false }
  end
  return res
end

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
        -- LSP servers
        "bash-language-server",
        "biome",
        "clangd",
        "css-lsp",
        "gopls",
        "harper-ls",
        "haskell-language-server",
        "html-lsp",
        "jdtls",
        "lua-language-server",
        "protols",
        "pyright",
        "ruff",
        "tailwindcss-language-server",
        "texlab",
        "wgsl-analyzer",

        -- Formatters
        "black",
        "clang-format",
        "prettier",
        "stylua",
      },
    },
  },

  -- use treesitter to auto close and/or rename HTML tags
  {
    "windwp/nvim-ts-autotag",
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

  -- Highlighting tags like `TODO`, `FIX`, `NOTE` etc.
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
    event = "VeryLazy",
  },

  {
    "pocco81/auto-save.nvim",
    event = "VeryLazy",
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
    event = "CursorMoved",
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
      on_attach = function(bufnr)
        local gitsigns = require "gitsigns"

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]c", function()
          if vim.wo.diff then
            vim.cmd.normal { "]c", bang = true }
          else
            gitsigns.nav_hunk "next"
          end
        end)
        map("n", "<leader>hn", function()
          if vim.wo.diff then
            vim.cmd.normal { "]c", bang = true }
          else
            gitsigns.nav_hunk "next"
          end
        end)

        map("n", "[c", function()
          if vim.wo.diff then
            vim.cmd.normal { "[c", bang = true }
          else
            gitsigns.nav_hunk "prev"
          end
        end)

        -- Actions
        map("n", "<leader>hs", gitsigns.stage_hunk)
        map("n", "<leader>hr", gitsigns.reset_hunk)

        map("v", "<leader>hs", function()
          gitsigns.stage_hunk { vim.fn.line ".", vim.fn.line "v" }
        end)

        map("v", "<leader>hr", function()
          gitsigns.reset_hunk { vim.fn.line ".", vim.fn.line "v" }
        end)

        map("n", "<leader>hS", gitsigns.stage_buffer)
        map("n", "<leader>hR", gitsigns.reset_buffer)
        map("n", "<leader>hp", gitsigns.preview_hunk)
        map("n", "<leader>hi", gitsigns.preview_hunk_inline)

        map("n", "<leader>hb", function()
          gitsigns.blame_line { full = true }
        end)
        map(
          "n",
          "<leader>gb",
          gitsigns.blame_line,
          { desc = "Show short blame for line under cursor." }
        )

        map("n", "<leader>hd", gitsigns.diffthis)

        map("n", "<leader>hD", function()
          gitsigns.diffthis "~"
        end)

        map("n", "<leader>hQ", function()
          gitsigns.setqflist "all"
        end)
        map("n", "<leader>hq", gitsigns.setqflist)

        -- Toggles
        map("n", "<leader>tb", gitsigns.toggle_current_line_blame)
        map("n", "<leader>tw", gitsigns.toggle_word_diff)

        -- Text object
        map({ "o", "x" }, "ih", gitsigns.select_hunk)
      end,
    },
  },

  -- Some semblance of Java support (just use IntelliJ)
  {
    "nvim-java/nvim-java",
    ft = "java",
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

  {
    "ibhagwan/fzf-lua",
    dependencies = { "echasnovski/mini.icons" },
    opts = {},
  },

  { "tpope/vim-repeat", event = "BufReadPost" },

  -- Markdown rendering
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "echasnovski/mini.icons",
    },
    ft = { "markdown", "quarto" }, -- lazy-load on filetype
    opts = {
      enabled = false, -- off by default
      latex = { enabled = false },
    },
  },

  {
    "GCBallesteros/jupytext.nvim",
    config = true,
    ft = "*.ipynb",
  },

  { "itchyny/lightline.vim", event = "VeryLazy" },

  { "dlyongemallo/diffview.nvim", event = "VeryLazy" },

  {
    "stevearc/oil.nvim",
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
  },

  disabled_plugins(),
}
