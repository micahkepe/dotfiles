require "nvchad.options"

local o = vim.o
local opt = vim.opt

-- Cursorline
o.cursorlineopt = "both" -- to enable cursorline!

-- Make line numbers defaults
o.number = true

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
