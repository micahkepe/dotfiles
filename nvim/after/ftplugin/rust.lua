local bufnr = vim.api.nvim_get_current_buf()
local map = vim.keymap.set

map("n", "<leader>fc", function()
  vim.cmd.RustLsp "flyCheck"
end, { desc = "Run Rust Fly Check", silent = true, buffer = bufnr })
