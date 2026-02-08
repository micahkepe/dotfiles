return {
  {
    "gelguy/wilder.nvim",
    event = "CmdlineEnter",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local wilder = require "wilder"
      wilder.setup { modes = { ":" } }
      wilder.set_option("pipeline", {
        wilder.branch(
          wilder.cmdline_pipeline {
            fuzzy = 1,
          },
          wilder.vim_search_pipeline()
        ),
      })

      wilder.set_option(
        "renderer",
        wilder.popupmenu_renderer {
          highlighter = wilder.basic_highlighter(),
          left = { " ", wilder.popupmenu_devicons() },
          right = { " ", wilder.popupmenu_scrollbar { thumb_char = " " } },
          highlights = {
            default = "WilderMenu",
            accent = wilder.make_hl("WilderAccent", "Pmenu", {
              { a = 1 },
              { a = 1 },
              { foreground = "#f4468f" },
            }),
          },
        }
      )
    end,
  },
}
