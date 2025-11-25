return {
  {
    "saghen/blink.cmp",
    -- Modify parent NvChad specs
    -- See: https://lazy.folke.io/spec#spec-setup
    opts = function(_, opts)
      opts.cmdline = opts.cmdline or {}
      opts.cmdline.enabled = false
    end,
  },
}
