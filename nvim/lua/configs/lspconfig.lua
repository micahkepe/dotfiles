local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

-- LSP Servers with no additional configuration needed
-- NOTE: servers configured explicitly below (gopls, clangd, cssls,
-- tailwindcss, harper_ls, lua_ls) are NOT listed here to avoid
-- double-config. typescript-tools.nvim manages the TS server.
local servers = {
  "bashls",
  "biome",
  "jdtls",
  "protols",
  "pyright",
  "ruff",
  "texlab",
}

for _, lsp in ipairs(servers) do
  vim.lsp.config(lsp, {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  })
end

-- wgsl_analyzer
-- https://github.com/wgsl-analyzer/wgsl-analyzer/blob/main/docs/book/src/other_editors.md#vimneovim
vim.lsp.config("wgsl_analyzer", {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  filetypes = { "wgsl", "wesl" },
})
vim.lsp.enable "wgsl_analyzer"

-- CSS LSP — silence Tailwind v4 at-rule warnings
vim.lsp.config("cssls", {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  settings = {
    css = { lint = { unknownAtRules = "ignore" } },
  },
})
vim.lsp.enable "cssls"

-- Enable all the servers
vim.lsp.enable(servers)

-- Finicky LSPs that have additional configuration

-- Golang LSP
vim.lsp.config("gopls", {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
        shadow = true,
      },
      staticcheck = true,
    },
  },
})
vim.lsp.enable "gopls"

-- C LSP
vim.lsp.config("clangd", {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  cmd = { "clangd" }, -- Ensure clangd is being used
  filetypes = { "c", "cpp", "objc", "objcpp" },
})
vim.lsp.enable "clangd"

-- Tailwind CSS LSP
vim.lsp.config("tailwindcss", {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  filetypes = {
    "css",
    "html",
    "javascript",
    "javascriptreact",
    "rust",
    "svelte",
    "typescript",
    "typescriptreact",
    "vue",
  },
  init_options = {
    userLanguages = {
      eelixir = "html-eex",
      eruby = "erb",
      rust = "html",
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
})
vim.lsp.enable "tailwindcss"

-- Harper LSP
vim.lsp.config("harper_ls", {
  cmd = { "harper-ls", "--stdio" },
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
})
-- Disable Harper on startup, enable with explicit ":LspStart harper_ls"
-- vim.lsp.enable "harper_ls"

-- Lua
-- https://github.com/neovim/nvim-lspconfig/blob/master/lsp/lua_ls.lua
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          vim.fn.expand "$VIMRUNTIME/lua",
          "{3rd}/luv/library",
          "{3rd}/busted/library",
        },
        checkThirdParty = false,
      },
    },
  },
})
vim.lsp.enable "lua_ls"
