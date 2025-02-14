require "nvchad.options"

local o = vim.o
local opt = vim.opt
local keyset = vim.keymap.set

-- Cursorline
o.cursorlineopt = "both" -- to enable cursorline!

-- Set relative numbering
opt.relativenumber = true

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

-- set spelllang
opt.spelllang = "en_us"

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
