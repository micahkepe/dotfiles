local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- LSP Servers with no configuration needed
-- NOTE: Rust lsp setup managed by `mrcjkb/rustaceanvim` plugin
local servers = {
  "html",
  "cssls",
  "pyright",
  "ts_ls",
  "gdscript",
  "texlab",
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

-- C LSP
lspconfig.clangd.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  cmd = { "clangd" }, -- Ensure clangd is being used
  filetypes = { "c", "cpp", "objc", "objcpp" },
}

-- Tailwind CSS LSP
lspconfig.tailwindcss.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  filetypes = {
    "html",
    "javascriptreact",
    "typescriptreact",
    "javascript",
    "typescript",
    "vue",
    "svelte",
  },
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

-- Harper LSP
lspconfig.harper_ls.setup {
  settings = {
    ["harper-ls"] = {
      userDictPath = "",
      fileDictPath = "",
      linters = {
        SpellCheck = true,
        SpelledNumbers = false,
        AnA = true,
        SentenceCapitalization = false,
        UnclosedQuotes = true,
        WrongQuotes = false,
        LongSentences = true,
        RepeatedWords = true,
        Spaces = true,
        Matcher = true,
        CorrectNumberSuffix = true,
      },
      codeActions = {
        ForceStable = false,
      },
      markdown = {
        IgnoreLinkTitle = false,
      },
      diagnosticSeverity = "hint",
      isolateEnglish = false,
    },
  },
}
