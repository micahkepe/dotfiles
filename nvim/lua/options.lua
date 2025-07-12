require "nvchad.options"

local o = vim.o
local opt = vim.opt
local keyset = vim.keymap.set

-- Cursorline
o.cursorlineopt = "both"

-- v0.11: Use rounded border around floating menus
o.winborder = "rounded"

-- Set relative numbering
opt.relativenumber = true

-- Spelling
o.spell = true
o.spelllang = "en_us"

-- Search and replace
opt.ignorecase = true -- ignore case letters when searching
opt.smartcase = true -- match case if capital letter is present
opt.incsearch = true -- show search matches as you type
opt.inccommand = "split" -- show live preview of substitute commands

-- disable swapfile
opt.swapfile = false

-- clipboard
opt.clipboard:append "unnamedplus"

-- text wrapping
o.wrap = false

-- ensure wild menu is set (plugin or otherwise)
o.wildmenu = true

-- appearance
o.termguicolors = true
o.background = "dark"

-- retain yank register contents when pasting over visual selected content
keyset("x", "<leader>p", [["_dP"]])

-- yank from cursor position to end of line
keyset("n", "<leader>Y", [["+Y]])

-- undo history
opt.undofile = true
keyset("i", ",", ",<C-g>U")
keyset("i", ".", ".<C-g>U")
keyset("i", "!", "!<C-g>U")
keyset("i", "?", "?<C-g>U")

-- Recommended options for `auto-session` plugin
o.sessionoptions =
  "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

local enable_providers = {
  "python3_provider",
  "node_provider",
  -- and so on
}

for _, plugin in pairs(enable_providers) do
  vim.g["loaded_" .. plugin] = nil
  vim.cmd("runtime " .. plugin)
end
