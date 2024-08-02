require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Map <ESC> to exit terminal mode
map("t", "<ESC>", "<C-\\><C-n>")

-- Map mp to open markdown preview
map("n", "<leader>mp", "<cmd>MarkdownPreview<cr>")

