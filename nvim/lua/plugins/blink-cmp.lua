return {
  "saghen/blink.cmp",
  dependencies = { "rafamadriz/friendly-snippets" },
  version = "*", -- Use the latest release tag
  opts = {
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    keymap = {
      preset = "none", -- Disable default mappings to avoid conflicts
      ["<Tab>"] = { "select_next", "fallback" }, -- Tab to go to next item
      ["<S-Tab>"] = { "select_prev", "fallback" }, -- Shift+Tab to go to previous item
    },
    appearance = {
      nerd_font_variant = "mono", -- Proper icon alignment
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
  },
  opts_extend = { "sources.default" },
}
