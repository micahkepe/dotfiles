require "nvchad.mappings"

local map = vim.keymap.set
local del = vim.keymap.del

-- remove nvim-tree mappings from NvChad defaults
del("n", "<C-n>")
del("n", "<leader>e")
del("n", "<leader>h")

-- override NvChad mappings for window navigation so I can use them for
-- vim-tmux-navigator
map("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", { desc = "Navigate left" })
map("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>", { desc = "Navigate down" })
map("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>", { desc = "Navigate up" })
map("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>", { desc = "Navigate right" })
map(
  "n",
  "<C-\\>",
  "<cmd>TmuxNavigatePrevious<cr>",
  { desc = "Navigate previous" }
)

-- tmux-sessionizer
map("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- Map <C-s> to save
map(
  { "n", "i", "v" },
  "<C-s>",
  "<cmd> w <cr>",
  { desc = "Save the current buffer " }
)

-- Adjust color column
map("n", "<leader>er", ":set colorcolumn=", { desc = "Adjust colorcolumn" })

-- Remove whitespace in buffer
map(
  "n",
  "<leader>ss",
  ":StripWhitespace<CR>",
  { desc = "Strip whitespace in current buffer" }
)

-- window management
map("n", "<leader>v", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
map("n", "<leader>sd", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window
map("n", "<leader>se", "<C-w>=", { desc = "Equalize splits" }) -- equalize split layouts

-- maintain visual context on page navigation and searching
map("n", "<C-d>", "<C-d>zz") -- Keeps cursor centered when going down the page
map("n", "<C-u>", "<C-u>zz") -- Keeps cursor centered when going up the page
map("n", "n", "nzzzv") -- Keeps the search result in the center after jumping to next result
map("n", "N", "Nzzzv") -- Keeps the search result in the center after jumping to previous result

-- New v0.12 Nvim tools (:h news)
-- undo tree
map("n", "<leader>u", function()
  vim.cmd.packadd "nvim.undotree"
  vim.cmd.Undotree()
end, { desc = "Toggle undo tree" })

-- Better navigation when lines are wrapped
-- When a count is provided (e.g., '5j'), then move by physical lines,
-- otherwise default to move by display lines
map("n", "j", "(v:count ? 'j' : 'gj')", { expr = true })
map("n", "k", "(v:count ? 'k' : 'gk')", { expr = true })

-- AutoSession mappings
map(
  "n",
  "<leader>ws",
  "<cmd>AutoSession save<CR>",
  { desc = "Save session for auto session root dir" }
)
map(
  "n",
  "<leader>wr",
  "<cmd>SessionRestore<CR>",
  { desc = "Restore session for cwd" }
)

-- Toggle auto-saving
map("n", "<leader>as", ":ASToggle<CR>", { desc = "Toggle auto-saving" })

-- VimTeX mappings
map(
  "n",
  "<leader>ll",
  "<cmd>VimtexCompile<CR>",
  { desc = "Compile LaTeX document" }
)
map("n", "<leader>lv", "<cmd>VimtexView<CR>", { desc = "View LaTeX document" })
map(
  "n",
  "<leader>le",
  "<cmd>VimtexErrors<CR>",
  { desc = "Open LaTeX errors in Quickfix menu" }
)

-- SPELLING

-- Correct the previous spelling mistake with <C-l> in Insert mode
-- Adapted from:
--  https://castel.dev/post/lecture-notes-1/#correcting-spelling-mistakes-on-the-fly
vim.api.nvim_set_keymap(
  "i",
  "<C-l>",
  "<C-g>u<Esc>[s1z=`]a<C-g>u",
  { noremap = true, silent = true }
)

-- Snacks.nvim QoL mappings
local snacks = require "snacks"
map("n", "<leader>gh", function()
  snacks.gitbrowse.open { what = "repo" }
end, { desc = "Open remote repo in default browser" })

-- switching to snacks.picker over Telescope
-- Options reference:
--  https://github.com/folke/snacks.nvim/blob/main/docs/picker.md
--  find mappings (prefixed with `f`)
map("n", "<leader>ff", function()
  snacks.picker.smart()
end, { desc = "Find files" })
map("n", "<leader>w", function()
  snacks.picker.grep()
end, { desc = "Grep" })
map("n", "<leader>fb", function()
  snacks.picker.buffers()
end, { desc = "Buffers" })
map("n", "<leader>fr", function()
  snacks.picker.recent()
end, { desc = "Recent Files" })
map("n", "<leader>fc", function()
  snacks.picker.files { cwd = vim.fn.stdpath "config" }
end, { desc = "Find Config Files" })
map("n", "<leader>fo", function()
  snacks.picker.oldfiles()
end, { desc = "Old Files" })
map("n", "<leader>fw", function()
  snacks.picker.grep_word()
end, { desc = "Find Word" })
map("n", "<leader>fd", function()
  snacks.picker.diagnostics()
end, { desc = "Find Diagnostics" })
map("n", "<leader>fh", function()
  snacks.picker.help()
end, { desc = "Find Help" })
-- search (prefixed with `s`)
map("n", "<leader>sm", function()
  snacks.picker.marks()
end, { desc = "Search Marks" })
map("n", "<leader>sh", function()
  snacks.picker.search_history()
end, { desc = "Search History" })
map("n", "<leader>sc", function()
  snacks.picker.command_history()
end, { desc = "Command History" })
-- Open references in Snack's picker instead of Quickfix menu
map("n", "grr", function()
  snacks.picker.lsp_references()
end, { nowait = true, desc = "Goto References" })

-- LSP
map("n", "<leader>ca", function()
  vim.lsp.buf.code_action()
end, { desc = "Show Code Actions" })

-- incremental selection (builtin treesitter)
map({ "x", "o" }, "<C-Space>", function()
  if vim.treesitter.get_parser(nil, nil, { error = false }) then
    require("vim.treesitter._select").select_parent(vim.v.count1)
  else
    vim.lsp.buf.selection_range(vim.v.count1)
  end
end, { desc = "Expand to parent node" })

map({ "x", "o" }, "<BS>", function()
  if vim.treesitter.get_parser(nil, nil, { error = false }) then
    require("vim.treesitter._select").select_child(vim.v.count1)
  else
    vim.lsp.buf.selection_range(-vim.v.count1)
  end
end, { desc = "Shrink to child node" })

-- little Lua goodies a la teej
map(
  "n",
  "<leader><leader>x",
  "<cmd>source %<CR>",
  { desc = "Execute the current Lua file" }
)
map("n", "<leader>lx", ":.lua<CR>", { desc = "Execute the current Lua line" })
map(
  "v",
  "<leader>x",
  ":lua<CR>",
  { desc = "Execute the visually selected Lua line(s)" }
)
map("n", "<leader>cl", function()
  vim.lsp.codelens.enable(not vim.lsp.codelens.is_enabled { bufnr = 0 })
  local cl_enabled = vim.lsp.codelens.is_enabled { bufnr = 0 }
  if cl_enabled then
    vim.notify("CodeLens ON ✔", vim.log.levels.INFO)
  else
    vim.notify("CodeLens OFF ✘", vim.log.levels.INFO)
  end
end, { desc = "Toggle CodeLens for the current buffer" })

-- `rustaceannvim`
map(
  "n",
  "<leader>rd",
  ":RustLsp openDocs<CR>",
  { desc = "Open Rust documentation for the symbol under the cursor" }
)

-- Clear all buffers except the current
-- See: https://stackoverflow.com/a/42071865/25337875
map(
  "n",
  "<leader>cb",
  ":%bd|e#<CR>",
  { desc = "Clear all buffers except for the current buffer" }
)

-- Clear ALL buffers
map("n", "<leader>Cb", ":bufdo bd<CR>", { desc = "Clear all buffers" })

-- Zen mode (w/ Goyo)
map("n", "<leader>z", ":Goyo<CR>", { desc = "Toggle Zen mode" })
