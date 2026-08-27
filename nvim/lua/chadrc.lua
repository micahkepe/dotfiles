-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua

local M = {}

-- colorscheme
M.base46 = {
  theme = "gruvbox",
  transparency = false,
  hl_override = {
    -- override comment highlighting to be more visible
    ["@comment"] = { italic = true, fg = "yellow" },
    ["Comment"] = { italic = true, fg = "yellow" },
    ["@lsp.type.comment"] = { italic = true, fg = "yellow" },

    -- make windows panes more distinguishable
    ["WinSeparator"] = { fg = "grey_fg2" },

    -- Color column ruler
    ["ColorColumn"] = { fg = "#676e95", bg = "none" },

    -- Diff highlighting is background only: syntax keeps the foreground, so an
    -- fg here would fight the colorscheme. base46's git integration also gives
    -- DiffChange and DiffText the same bg, which hides within-line diffs.
    -- One hue per state, and DiffText a lighter DiffChange.
    ["DiffAdd"] = { fg = "NONE", bg = { "green", "black", 85 } },
    ["DiffDelete"] = { fg = "NONE", bg = { "red", "black", 85 } },
    ["DiffChange"] = { fg = "NONE", bg = { "blue", "black", 88 } },
    ["DiffText"] = { fg = "NONE", bg = { "blue", "black", 65 } },
  },

  -- snacks.nvim w/ gruvbox has atrocious contrast in the file listing
  hl_add = {
    ["SnacksPickerDir"] = { fg = "#a89984" },
    ["SpellBad"] = { undercurl = true, sp = "red" },

    -- Diffview paints the rows padding one side of a diff with this, and only
    -- links it to Comment as a default, so defining it here wins.
    ["DiffviewDiffDeleteDim"] = { fg = "NONE", bg = { "red", "black", 93 } },
  },
}

M.ui = {
  statusline = {
    enabled = false,
  },
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
      txt = "⏲  Open last session",
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
