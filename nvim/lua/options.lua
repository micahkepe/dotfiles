require "nvchad.options"

-- add yours here!

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

-- Editor ruleline
function _G.toggle_colorcolumn()
  if vim.wo.colorcolumn == "80" then
    vim.wo.colorcolumn = ""
  else
    vim.wo.colorcolumn = "80"
  end
end
