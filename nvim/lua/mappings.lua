require "nvchad.mappings"

local map = vim.keymap.set

-- override nvchad mappings for window navigation so I can use them for
-- vim-tmux-navigator
map("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", { desc = "Navigate left" })
map("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>", { desc = "Navigate down" })
map("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>", { desc = "Navigate up" })
map("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>", { desc = "Navigate right" })
map("n", "<C-\\>", "<cmd>TmuxNavigatePrevious<cr>", { desc = "Navigate previous" })

-- Quick escape from insert mode
map("i", "jk", "<ESC>")

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
    dapui.toggle {}
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false) -- Spaces buffers evenly
  end, { desc = "Start debugging session" })

  -- Hover to get variable value
  map("n", "<leader>dl", require("dap.ui.widgets").hover, { desc = "Hover to show variable value" })

  -- Continue execution
  map("n", "<leader>dc", dap.continue, { desc = "Continue execution" })

  -- Toggle breakpoint
  map("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })

  -- Step over
  map("n", "<leader>dn", dap.step_over, { desc = "Step over" })

  -- Step into
  map("n", "<leader>di", dap.step_into, { desc = "Step into" })

  -- Step out
  map("n", "<leader>do", dap.step_out, { desc = "Step out" })

  -- Clear all breakpoints
  map("n", "<leader>dC", function()
    dap.clear_breakpoints()
    require "notify"("Breakpoints cleared", "warn")
  end, { desc = "Clear all breakpoints" })

  -- Terminate debugging session and clear breakpoints
  map("n", "<leader>de", function()
    dap.clear_breakpoints()
    dapui.toggle {}
    dap.terminate()
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false)
    require "notify"("Debugger session ended", "warn")
  end, { desc = "Terminate debugging session" })
else
  require "notify"("nvim-dap or dap-ui not installed!", "warning")
end

-- Sioyek PDF viewer mappings
vim.api.nvim_create_user_command("OpenPDFWithSioyek", function()
  local current_file = vim.fn.expand "%:p"
  if current_file:match "%.pdf$" then
    -- Open the PDF file with Sioyek (can be changed to any other PDF viewer)
    vim.fn.system('open -a sioyek "' .. current_file .. '"')
  else
    vim.notify("Current file is not a PDF", vim.log.levels.WARN)
  end
end, {})

-- Map <leader>sp to open PDF with Sioyek
map("n", "<leader>sp", ":OpenPDFWithSioyek<CR>", { noremap = true, silent = true, desc = "Open PDF with Sioyek" })

-- Toggle colorcolumn for editor ruler at 80 characters
map("n", "<leader>er", function()
  vim.g.toggle_virtcolumn()
end, { desc = "Toggle virtcolumn at 80 characters" })

-- Keyboard users
vim.keymap.set("n", "<C-t>", function()
  require("menu").open "default"
end, {})

-- mouse users + nvimtree users!
vim.keymap.set("n", "<RightMouse>", function()
  vim.cmd.exec '"normal! \\<RightMouse>"'

  local options = vim.bo.ft == "NvimTree" and "nvimtree" or "default"
  require("menu").open(options, { mouse = true })
end, {})

-- window management
map("n", "<leader>v", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
map("n", "<leader>sd", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window
map("n", "<leader>se", "<C-w>=", { desc = "Equalize splits" }) -- equalize split layouts
-- can't use <leader>sh since that is used by LSPs to signature help
map("n", "<leader>s", "<cmd>split<CR>", { desc = "Split window horizontally" }) -- split window horizobtally

-- maintain visual context on page navigation and searching
map("n", "<C-d>", "<C-d>zz") -- Keeps cursor centered when going down the page
map("n", "<C-u>", "<C-u>zz") -- Keeps cursor centered when going up the page
map("n", "n", "nzzzv") -- Keeps the search result in the center after jumping to next result
map("n", "N", "Nzzzv") -- Keeps the search result in the center after jumping to previous result

-- gitsigns mappings
map("n", "<leader>hn", "<cmd>lua require'gitsigns'.next_hunk()<CR>", { desc = "Next hunk" })
map("n", "<leader>hp", "<cmd>lua require'gitsigns'.prev_hunk()<CR>", { desc = "Previous hunk" })
map("n", "<leader>hs", "<cmd>lua require'gitsigns'.stage_hunk()<CR>", { desc = "Stage hunk" })
map("n", "<leader>hu", "<cmd>lua require'gitsigns'.undo_stage_hunk()<CR>", { desc = "Undo stage hunk" })
map("n", "<leader>hr", "<cmd>lua require'gitsigns'.reset_hunk()<CR>", { desc = "Reset hunk" })
map("n", "<leader>hR", "<cmd>lua require'gitsigns'.reset_buffer()<CR>", { desc = "Reset buffer" })
map("n", "<leader>hp", "<cmd>lua require'gitsigns'.preview_hunk()<CR>", { desc = "Preview hunk" })
map("n", "<leader>hb", "<cmd>lua require'gitsigns'.blame_line()<CR>", { desc = "Blame line" })
map("n", "<leader>hS", "<cmd>lua require'gitsigns'.stage_buffer()<CR>", { desc = "Stage buffer" })
map("n", "<leader>hU", "<cmd>lua require'gitsigns'.reset_buffer_index()<CR>", { desc = "Reset buffer index" })

-- undo tree
map("n", "<leader>u", ":UndotreeToggle<cr>", { desc = "Toggle undo tree" })

-- Map <leader>ff to search for files with hidden files shown
map(
  "n",
  "<leader>ff",
  ":Telescope find_files find_command=rg,--ignore,--hidden,--files,--glob,!.git,--glob,!node_modules<CR>",
  { desc = "Find files including hidden ones, ignoring .git and node_modules" }
)

-- Better navigation when lines are wrapped
map("n", "j", "(v:count ? 'j' : 'gj')", { expr = true })
map("n", "k", "(v:count ? 'k' : 'gk')", { expr = true })

-- Autosession mappings
map("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "Save session for auto session root dir" })
map("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "Restore session for cwd" })

-- Toggle auto-saving
map("n", "<leader>as", ":ASToggle<CR>", { desc = "Toggle auto-saving" })
