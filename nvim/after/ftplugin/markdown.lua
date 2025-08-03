local map = vim.keymap.set

-- Set text width to 80 columns
vim.bo.textwidth = 80

-- Generate table of contents with `gh-md-toc`
map("n", "<leader>toc", ":0read !gh-md-toc --hide-footer %<CR>", {
  desc = "Insert Table of Contents for the current Markdown file at first line",
})
