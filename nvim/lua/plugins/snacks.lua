---@diagnostic disable: undefined-doc-name
-- QoL plugin collection
-- For more information and options reference:
--  https://github.com/folke/snacks.nvim?tab=readme-ov-file#-usage
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    scroll = { enabled = true },
    gitbrowse = { enabled = true },
    picker = { enabled = true },
    quickfile = { enabled = true },
    image = {
      doc = {
        float = true,
        inline = false,
      },
    },
    input = { enabled = true },
    notifier = { enabled = false },
  },
}
