return {
  {
    "gelguy/wilder.nvim",
    event = "CmdlineEnter",
    build = ":UpdateRemotePlugins",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local wilder = require "wilder"
      wilder.setup { modes = { ":" } }

      wilder.set_option(
        "renderer",
        wilder.popupmenu_renderer {
          highlighter = wilder.basic_highlighter(),
          left = { " " },
          right = { " ", wilder.popupmenu_scrollbar { thumb_char = " " } },
          highlights = { default = "WilderMenu", accent = "WilderAccent" },
        }
      )
    end,
  },
}
