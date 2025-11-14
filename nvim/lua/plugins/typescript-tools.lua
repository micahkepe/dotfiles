return {
  "pmizio/typescript-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  ft = { "typescript", "javascript" },
  -- https://github.com/pmizio/typescript-tools.nvim/blob/master/README.md#%EF%B8%8F-configuration
  opts = {
    settings = {
      separate_diagnostic_server = true,
      tsserver_max_memory = "auto",
      complete_function_calls = false,
      include_completions_with_insert_text = true,
    },
  },
}
