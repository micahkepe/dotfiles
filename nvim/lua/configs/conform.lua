local options = {
  -- For Biome language support, see: https://biomejs.dev/internals/language-support/
  formatters_by_ft = {
    bash = { "shfmt" },
    c = { "clang-format" },
    css = { "biome" },
    haskell = { "fourmolu" },
    html = { "biome" },
    javascript = { "biome" },
    json = { "biome", "prettier" },
    lua = { "stylua" },
    markdown = { "prettier" },
    nix = { "alejandra " },
    python = { "ruff", "black" },
    rust = { "rustfmt" },
    sh = { "shfmt" },
    typescript = { "biome" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 2500,
    lsp_fallback = true,
  },
}

require("conform").setup(options)
