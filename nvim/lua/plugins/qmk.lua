return {
  "codethread/qmk.nvim",
  ft = { "dts" },
  config = function()
    local conf = {
      name = "LAYOUT_toucan",
      layout = {
        "x x x x x x _ x x x x x x",
        "x x x x x x _ x x x x x x",
        "x x x x x x _ x x x x x x",
        "_ _ _ x x x _ x x x _ _ _",
      },
      variant = "zmk",
    }
    require("qmk").setup(conf)
  end,
}
