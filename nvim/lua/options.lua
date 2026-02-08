require "nvchad.options"

local o = vim.o
local opt = vim.opt
local keyset = vim.keymap.set

-- Undo directory to persistent undo tree
o.undodir = os.getenv "HOME" .. "/.vim/undodir"
-- Auto restore and save undo history on buffer reads and writes
o.undofile = true

-- :h fuzzy-matching
vim.cmd "set completeopt+=fuzzy"

-- Git diff
o.diffopt = "algorithm:histogram"

-- Cursorline
o.cursorlineopt = "both"

-- v0.11: Use rounded border around floating menus
o.winborder = "rounded"

-- Set relative numbering
opt.relativenumber = true

-- Spelling
o.spell = true
o.spelllang = "en_us"

-- Confirmation dialog prompt
o.confirm = true

-- Search and replace
opt.ignorecase = true -- ignore case letters when searching
opt.smartcase = true -- match case if capital letter is present
opt.incsearch = true -- show search matches as you type
opt.inccommand = "split" -- show live preview of substitute commands

-- disable swapfile
opt.swapfile = false

-- use visual bell over beeping because why would I want that ¯\_(ツ)_/¯
o.visualbell = true

opt.listchars = "tab:^ ,nbsp:¬,extends:»,precedes:«,trail:•"

o.signcolumn = "yes"

-- clipboard
opt.clipboard:append "unnamedplus"

-- text wrapping
o.wrap = false

-- ensure wild menu is set (plugin or otherwise)
o.wildmenu = true
opt.wildmode = { "longest:full", "full" }
opt.wildoptions = { "pum" }
opt.wildignorecase = true

-- appearance
o.termguicolors = true
o.background = "dark"
opt.colorcolumn = "80"

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

-- "very magic" (less escaping needed) regexes by default
-- Taken from: https://github.com/jonhoo/configs/blob/master/editor/.config/nvim/init.lua
vim.keymap.set("n", "?", "?\\v")
vim.keymap.set("n", "/", "/\\v")
vim.keymap.set("c", "%s/", "%sm/")

-- Logging (turn off to avoid "Large LSP log" warning)
-- https://neovim.discourse.group/t/lsp-log-file-grows-infinitely/3596
-- See `:h  vim.lsp.set_log_level()`
--
-- When debugging a language server, comment this line out to start logging
vim.lsp.set_log_level "OFF"
