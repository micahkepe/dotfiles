local options = {
  -- For Biome language support, see: https://biomejs.dev/internals/language-support/
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "biome", "prettier" },
    html = { "biome", "prettier" },
    markdown = { "prettier" },
    c = { "clang-format" },
    javascript = { "biome" },
    typescript = { "biome" },
    json = { "biome", "prettier" },
    python = { "ruff", "black" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 2500,
    lsp_fallback = true,
  },
}

require("conform").setup(options)
