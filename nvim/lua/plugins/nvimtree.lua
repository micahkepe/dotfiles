return {
  {
    "nvim-tree/nvim-tree.lua",
    -- Modify parent NvChad specs
    -- See: https://lazy.folke.io/spec#spec-setup
    opts = function(_, opts)
      opts.filters = opts.filters or {}
      opts.filters.dotfiles = false
      opts.git = { enable = true }
      opts.filters.git_ignored = false
      opts.filters.custom = { "^\\.git$", "DS_Store" }

      return opts
    end,
  },
}
