-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua

local M = {}

-- colorscheme
M.base46 = {
  theme = "palenight",
  transparency = false,
  hl_override = {
    -- override comment highlighting to be more visible
    ["@comment"] = { italic = true, fg = "nord_blue" }, -- treesitter comment highlighting
    ["Comment"] = { italic = true, fg = "nord_blue" }, -- NVChad comment group

    -- make windows panes more distinguishable
    ["WinSeparator"] = { fg = "grey_fg2" },

    -- Color column ruler
    ["ColorColumn"] = { fg = "#676e95", bg = "none" },
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

  buttons = {
    {
      txt = "  Find File",
      keys = "ff",
      cmd = ":lua Snacks.picker.smart()<CR>",
    },
    {
      txt = "  Recent Files",
      keys = "fr",
      cmd = "lua Snacks.picker.recent()<CR>",
    },
    {
      txt = "󰈭  Find Word",
      keys = "fw",
      cmd = ":lua Snacks.picker.grep()<CR>",
    },
    {
      txt = "󱥚  Themes",
      keys = "th",
      cmd = ":lua require('nvchad.themes').open()",
    },
    { txt = "  Mappings", keys = "ch", cmd = "NvCheatsheet" },
    {
      txt = "  Open last session",
      keys = "l",
      cmd = ":AutoSession restore<CR>",
    },

    { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },

    {
      txt = function()
        ---@diagnostic disable-next-line: different-requires
        local stats = require("lazy").stats()
        local ms = math.floor(stats.startuptime) .. " ms"
        return "  Loaded "
          .. stats.loaded
          .. "/"
          .. stats.count
          .. " plugins in "
          .. ms
      end,
      hl = "NvDashFooter",
      no_gap = true,
    },

    { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },
  },
}

return M
