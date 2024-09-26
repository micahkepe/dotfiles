require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Map <C-s> to save
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Map <ESC> to exit terminal mode
map("t", "<ESC>", "<C-\\><C-n>")

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

-- Open file in default viewer
vim.api.nvim_create_user_command("OpenFileInViewer", function()
  local current_file = vim.fn.expand "%:p"
  vim.fn.system('open "' .. current_file .. '"')
end, {})

-- Map <leader>sv to open file in standard viewer
-- NOTE: if cursor is on the file name Nvim Tree, you can simply press `sv` to open the file in the default viewer
-- since the leader key is already used by Nvim Tree.
map("n", "<leader>sv", ":OpenFileInViewer<CR>", { noremap = true, silent = true, desc = "Open file in default viewer" })

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
