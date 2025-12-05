return {
  { import = "nvchad.blink.lazyspec" },

  {
    "saghen/blink.cmp",
    -- Modify parent NvChad specs
    -- See: https://lazy.folke.io/spec#spec-setup
    --
    -- blink.cmp options: https://cmp.saghen.dev/configuration/general.html
    opts = function(_, opts)
      opts.cmdline = opts.cmdline or {}
      opts.cmdline.enabled = false
      opts.completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
          window = { border = "single" },
        },
        menu = {
          draw = {
            -- We don't need label_description now because label and label_description are already
            -- combined together in label by colorful-menu.nvim.
            columns = { { "kind_icon" }, { "label", gap = 1 } },
            components = {
              label = {
                text = function(ctx)
                  return require("colorful-menu").blink_components_text(ctx)
                end,
                highlight = function(ctx)
                  return require("colorful-menu").blink_components_highlight(
                    ctx
                  )
                end,
              },
            },
          },
        },
      }
    end,
  },
}
