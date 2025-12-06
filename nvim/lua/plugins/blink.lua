return {
  { import = "nvchad.blink.lazyspec" },

  {
    "L3MON4D3/LuaSnip",
    dependencies = "rafamadriz/friendly-snippets",
    opts = { history = true, updateevents = "TextChanged,TextChangedI" },
    config = function(_, opts)
      require("luasnip").config.set_config(opts)
      require "nvchad.configs.luasnip"
      require("luasnip.loaders.from_lua").lazy_load {
        paths = "~/.config/nvim/lua/snippets/",
      }
    end,
  },

  {
    "saghen/blink.cmp",
    -- Modify parent NvChad specs
    -- See: https://lazy.folke.io/spec#spec-setup
    --
    -- blink.cmp options: https://cmp.saghen.dev/configuration/general.html
    opts = function(_, opts)
      local mods = {
        cmdline = { enabled = false },
        completion = {
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
        },
        fuzzy = { implementation = "prefer_rust_with_warning" },
      }
      return vim.tbl_deep_extend("force", opts, mods)
    end,
  },
}
