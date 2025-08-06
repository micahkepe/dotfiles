require "nvchad.mappings"

local map = vim.keymap.set

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
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Map mp to open markdown preview
map("n", "<leader>mp", "<cmd>MarkdownPreview<cr>")

-- Debugger mappings
local dap_ok, dap = pcall(require, "dap")
local dapui_ok, dapui = pcall(require, "dapui")

if dap_ok and dapui_ok then
  -- Debugger keybindings

  -- Start debugging session
  map("n", "<leader>ds", function()
    dap.continue()
    vim.api.nvim_feedkeys(
      vim.api.nvim_replace_termcodes("<C-w>=", false, true, true),
      "n",
      false
    ) -- Spaces buffers evenly
  end, { desc = "Toggle debugging session" })

  -- Hover to get variable value
  map(
    "n",
    "<leader>dl",
    require("dap.ui.widgets").hover,
    { desc = "Hover to show variable value" }
  )

  -- Continue execution
  map("n", "<leader>dc", dap.continue, { desc = "Continue execution" })

  -- Toggle breakpoint
  map("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })

  -- Conditional breakpoint
  map("n", "<leader>dB", function()
    dap.set_breakpoint(vim.fn.input "Breakpoint condition: ")
  end, { desc = "Set conditional breakpoint" })

  -- Step over
  map("n", "<leader>dn", dap.step_over, { desc = "Step over" })

  -- Step into
  map("n", "<leader>di", dap.step_into, { desc = "Step into" })

  -- Step out
  map("n", "<leader>do", dap.step_out, { desc = "Step out" })

  -- Clear all breakpoints
  map("n", "<leader>dC", function()
    dap.clear_breakpoints()
    vim.notify("Breakpoints cleared", vim.log.levels.WARN)
  end, { desc = "Clear all breakpoints" })

  -- Terminate debugging session and clear breakpoints
  map("n", "<leader>de", function()
    dap.clear_breakpoints()
    dap.terminate()
    vim.api.nvim_feedkeys(
      vim.api.nvim_replace_termcodes("<C-w>=", false, true, true),
      "n",
      false
    )
    vim.notify("Debugger session ended", vim.log.levels.INFO)
  end, { desc = "Terminate debugging session" })
else
  vim.notify("nvim-dap or dap-ui not installed!", vim.log.levels.WARN)
end

-- Adjust color column
map("n", "<leader>er", ":set colorcolumn=", { desc = "Adjust colorcolumn" })

-- Remove whitespace in buffer
map(
  "n",
  "<leader>ss",
  ":StripWhitespace<CR>",
  { desc = "Strip whitespace in current buffer" }
)

-- Cellular-automaton
map("n", "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>")

-- window management
map("n", "<leader>v", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
map("n", "<leader>sd", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window
map("n", "<leader>se", "<C-w>=", { desc = "Equalize splits" }) -- equalize split layouts
map("n", "<leader>h", "<cmd>split<CR>", { desc = "Split window horizontally" }) -- split window horizontally

-- maintain visual context on page navigation and searching
map("n", "<C-d>", "<C-d>zz") -- Keeps cursor centered when going down the page
map("n", "<C-u>", "<C-u>zz") -- Keeps cursor centered when going up the page
map("n", "n", "nzzzv") -- Keeps the search result in the center after jumping to next result
map("n", "N", "Nzzzv") -- Keeps the search result in the center after jumping to previous result

-- GitSigns mappings
map(
  "n",
  "<leader>hn",
  "<cmd>lua require'gitsigns'.next_hunk()<CR>",
  { desc = "Next hunk" }
)
map(
  "n",
  "<leader>hp",
  "<cmd>lua require'gitsigns'.prev_hunk()<CR>",
  { desc = "Previous hunk" }
)
map(
  "n",
  "<leader>hs",
  "<cmd>lua require'gitsigns'.stage_hunk()<CR>",
  { desc = "Stage hunk" }
)
map(
  "n",
  "<leader>hu",
  "<cmd>lua require'gitsigns'.undo_stage_hunk()<CR>",
  { desc = "Undo stage hunk" }
)
map(
  "n",
  "<leader>hr",
  "<cmd>lua require'gitsigns'.reset_hunk()<CR>",
  { desc = "Reset hunk" }
)
map(
  "n",
  "<leader>hR",
  "<cmd>lua require'gitsigns'.reset_buffer()<CR>",
  { desc = "Reset buffer" }
)
map(
  "n",
  "<leader>hp",
  "<cmd>lua require'gitsigns'.preview_hunk()<CR>",
  { desc = "Preview hunk" }
)
map(
  "n",
  "<leader>gb",
  "<cmd>lua require'gitsigns'.blame_line()<CR>",
  { desc = "Blame line" }
)
map(
  "n",
  "<leader>hS",
  "<cmd>lua require'gitsigns'.stage_buffer()<CR>",
  { desc = "Stage buffer" }
)
map(
  "n",
  "<leader>hU",
  "<cmd>lua require'gitsigns'.reset_buffer_index()<CR>",
  { desc = "Reset buffer index" }
)

-- undo tree
map("n", "<leader>u", ":UndotreeToggle<cr>", { desc = "Toggle undo tree" })

-- Better navigation when lines are wrapped
-- When a count is provided (e.g., '5j'), then move by physical lines,
-- otherwise default to move by display lines
map("n", "j", "(v:count ? 'j' : 'gj')", { expr = true })
map("n", "k", "(v:count ? 'k' : 'gk')", { expr = true })

-- Autosession mappings
map(
  "n",
  "<leader>ws",
  "<cmd>SessionSave<CR>",
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
-- Lazygit
map("n", "<leader>lg", function()
  snacks.lazygit.open()
end, { desc = "Open Lazygit" })
map("n", "<leader>ht", function()
  snacks.terminal()
end, { desc = "terminal new horizontal term" })
-- Open references in Snack's picker instead of Quickfix menu
map("n", "grr", function()
  snacks.picker.lsp_references()
end, { nowait = true, desc = "Goto References" })

-- LSP
map("n", "<leader>ca", function()
  vim.lsp.buf.code_action()
end, { desc = "Show Code Actions" })

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

-- RenderMarkdown mappings
map(
  "n",
  "<leader>rmd",
  ":RenderMarkdown buf_toggle<CR>",
  { desc = "Toggle Markdown Rendering for the Current Buffer" }
)
