-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

-- colorscheme
M.base46 = {
  theme = "onedark",
  hl_override = {
    -- override comment highlighting to be more visible
    ["@comment"] = { italic = true, fg = "white" },
  },
}

M.ui = {
  cmp = {
    format_colors = {
      tailwind = true,
    },
  },
}

M.nvdash = {
  load_on_startup = true,

  header = {
    [[                                                  ]],
    [[███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗]],
    [[████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║]],
    [[██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║]],
    [[██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║]],
    [[██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║]],
    [[╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
    [[                                                  ]],
    [[           Real men test in production.           ]],
    [[                                                  ]],
  },
}

return M
