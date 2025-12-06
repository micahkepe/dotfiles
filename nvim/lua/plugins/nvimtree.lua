return {
  {
    "nvim-tree/nvim-tree.lua",
    -- Modify parent NvChad specs
    -- See: https://lazy.folke.io/spec#spec-setup
    opts = function(_, opts)
      local mods = {
        filters = {
          dotfiles = false,
          git_ignored = false,
          custom = { "^\\.git$", "DS_Store" },
        },
        git = { enable = true },
      }
      return vim.tbl_deep_extend("force", opts, mods)
    end,
  },
}
