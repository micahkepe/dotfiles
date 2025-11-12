local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

-- LSP Servers with no configuration needed
-- NOTE: Rust LSP setup managed by `mrcjkb/rustaceanvim` plugin
local servers = {
  "html",
  "cssls",
  "bashls",
  "pyright",
  "ruff",
  "typescript-language-server",
  "gdscript",
  "texlab",
  "jdtls",
}

for _, lsp in ipairs(servers) do
  vim.lsp.config(lsp, {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  })
end

-- Enable all the servers
vim.lsp.enable(servers)

-- Finicky LSPs that have additional configuration

-- Golang LSP
vim.lsp.config("gopls", {
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
