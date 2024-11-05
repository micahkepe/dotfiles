-- EXAMPLE
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- Overriding NVChad's lspconfig setup to make diagnostics to make it more like
-- Visual Studio Code (no inline, underlined, window on cursor hold, etc.)
--#region

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = false, -- no inline diagnostics
  underline = true, -- underline the offending code
})

-- update diagnostics more frequently
vim.o.updatetime = 250

-- Open diagnostics automatically on cursor hold
vim.cmd [[autocmd cursorhold,cursorholdi * lua vim.diagnostic.open_float(nil, {focus=false})]]

--#endregion

-- LSP Servers with no configuration needed
local servers = {
  "html",
  "cssls",
  "rust_analyzer",
  "pyright",
  "ts_ls",
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

-- Finicky LSPs that have additional configuration

-- Golang LSP
lspconfig.gopls.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  cmd = { "gopls" },
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
        shadow = true,
      },
      staticcheck = true,
    },
  },
}

-- Tailwind CSS LSP
lspconfig.tailwindcss.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  filetypes = { "html", "javascriptreact", "typescriptreact", "javascript", "typescript", "vue", "svelte" },
  init_options = {
    userLanguages = {
      eelixir = "html-eex",
      eruby = "erb",
    },
  },
  settings = {
    tailwindCSS = {
      classAttributes = { "class", "className", "classList", "ngClass" },
      lint = {
        cssConflict = "warning",
        invalidApply = "error",
        invalidConfigPath = "error",
        invalidScreen = "error",
        invalidTailwindDirective = "error",
        invalidVariant = "error",
        recommendedVariantOrder = "warning",
      },
      validate = true,
    },
  },
}
