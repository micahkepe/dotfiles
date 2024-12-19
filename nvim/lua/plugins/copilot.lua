return {
  -- OPTION 1: use copilot as a completion source (with ghost text)
  -- This is the default option and replicates the behavior of the official "github/copilot.vim" plugin
  -- Adapted from LazyVim's Copilot plugin setup:
  --    https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/coding/copilot.lua
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    build = ":Copilot auth",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = false, -- need to explicitly use "next" or "prev" to generate
        debounce = 75,
        keymap = {
          accept = "<C-f>", -- accept the current suggestion in full
          accept_word = "<C-w>", -- accept the current word
          accept_line = "<C-l>", -- accept the current line
          next = "<C-n>",
          prev = "<C-p>",
          dismiss = "<C-x>",
        },
      },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
        ["."] = true,
        sh = function()
          if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), "^%.env.*") then
            -- disable for .env files
            return false
          end
          return true
        end,
      },
    },
    config = function(_, opts)
      require("copilot").setup(opts)
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    event = "VeryLazy",
    opts = function(_, opts)
      local function copilot_indicator()
        local clients = vim.lsp.get_clients { name = "copilot" }
        local copilot_active = #clients > 0
        return copilot_active and "󰚩 " or ""
      end
      table.insert(opts.sections.lualine_x, 2, { copilot_indicator })
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        "zbirenbaum/copilot-cmp",
        dependencies = "copilot.lua",
        config = function()
          require("copilot_cmp").setup()
        end,
      },
    },
    opts = function(_, opts)
      local cmp = require "cmp"
      opts.sources = cmp.config.sources {
        { name = "nvim_lsp", group_index = 2 },
        { name = "luasnip", group_index = 2 },
        { name = "buffer", group_index = 2 },
        { name = "nvim_lua", group_index = 2 },
        { name = "path", group_index = 2 },
      }
    end,
  },

  -- OPTION 2: use copilot as a source for nvim-cmp (no ghost text)
  -- To use copilot with nvim-cmp, uncomment the following block
  -- This may be a better option if you prefer keeping "InsertEnter" event for copilot,
  -- however, Copilot's multiline suggestions are harder to read in the cmp menu.
  -- {
  --   "zbirenbaum/copilot.lua",
  --   cmd = "Copilot",
  --   event = "InsertEnter",
  --   config = function()
  --     require("copilot").setup {
  --       suggestion = { enabled = true },
  --       panel = { enabled = false },
  --       filetypes = {
  --         markdown = true, -- enable copilot for markdown files
  --         ["."] = true,
  --         sh = function()
  --           if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), "^%.env.*") then
  --             -- disable for .env files
  --             return false
  --           end
  --           return true
  --         end,
  --       },
  --     }
  --   end,
  -- },
  --
  -- {
  --   "hrsh7th/nvim-cmp",
  --   dependencies = {
  --     {
  --       "zbirenbaum/copilot-cmp",
  --       config = function()
  --         require("copilot_cmp").setup()
  --       end,
  --     },
  --   },
  --   opts = {
  --     sources = {
  --       { name = "nvim_lsp" },
  --       { name = "luasnip" },
  --       { name = "buffer" },
  --       { name = "nvim_lua" },
  --       { name = "path" },
  --       { name = "copilot" },
  --     },
  --   },
  -- },
}
