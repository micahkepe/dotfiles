return {
  "pmizio/typescript-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  ft = { "typescript", "javascript" },
  -- https://github.com/pmizio/typescript-tools.nvim/blob/master/README.md#%EF%B8%8F-configuration
  opts = {
    settings = {
      separate_diagnostic_server = true,
      -- https://nodejs.org/api/cli.html#--max-old-space-sizesize-in-megabytes
      -- NOTE: "auto" does not
      tsserver_max_memory = 12288, -- ~12 GB
      complete_function_calls = false,
      include_completions_with_insert_text = true,

      -- https://github.com/microsoft/TypeScript/blob/v5.0.4/src/server/protocol.ts#L3439
      tsserver_file_preferences = {
        includeCompletionsForModuleExports = false,
        includePackageJsonAutoImports = "off",
        includeCompletionsWithSnippetText = true,
      },
    },
  },
}
