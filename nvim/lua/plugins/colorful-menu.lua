return {
  "xzbdmw/colorful-menu.nvim",
  config = function()
    -- You don't need to set these options.
    require("colorful-menu").setup {
      ft = {
        lua = {
          -- Maybe you want to dim arguments a bit.
          auguments_hl = "@comment",
        },
        go = {
          -- When true, label for field and variable will format like "foo: Foo"
          -- instead of go's original syntax "foo Foo".
          add_colon_before_type = false,
        },
        typescript = {
          -- Add more filetype when needed, these three taken from lspconfig are default value.
          enabled = { "typescript", "typescriptreact", "typescript.tsx" },
          -- Or "vtsls", their information is different, so we
          -- need to know in advance.
          ls = "typescript-language-server",
          extra_info_hl = "@comment",
        },
        ["rust-analyzer"] = {
          -- Such as (as Iterator), (use std::io).
          extra_info_hl = "@comment",
          -- Similar to the same setting of gopls.
          align_type_to_right = true,
          -- See https://github.com/xzbdmw/colorful-menu.nvim/pull/36
          preserve_type_when_truncate = true,
        },
        c = {
          -- Such as "From <stdio.h>"
          extra_info_hl = "@comment",
        },

        -- If true, try to highlight "not supported" languages.
        fallback = true,
      },
      -- If the built-in logic fails to find a suitable highlight group,
      -- this highlight is applied to the label.
      fallback_highlight = "@variable",
      -- If provided, the plugin truncates the final displayed text to
      -- this width (measured in display cells). Any highlights that extend
      -- beyond the truncation point are ignored. Default 60.
      max_width = 60,
    }
  end,
}
