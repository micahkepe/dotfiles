local options = {
  -- For Biome language support, see: https://biomejs.dev/internals/language-support/
  formatters_by_ft = {
    bash = { "shfmt" },
    c = { "clang-format" },
    css = { "biome" },
    haskell = { "fourmolu" },
    html = { "biome" },
    javascript = { "biome" },
    json = { "biome" },
    lua = { "stylua" },
    markdown = { "prettier" },
    nix = { "alejandra" },
    python = { "ruff_format", "ruff_organize_imports", "ruff_fix" },
    rust = { "rustfmt", lsp_format = "fallback" },
    sh = { "shfmt" },
    toml = { lsp_format = "never" },
    typescript = { "biome" },
  },

  default_format_opts = {
    lsp_format = "fallback",
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 2500,
  },
}

require("conform").setup(options)
