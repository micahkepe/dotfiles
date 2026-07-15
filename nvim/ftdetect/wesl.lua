vim.api.nvim_create_autocmd(
  { "BufRead", "BufNewFile" },
  { pattern = "*.wesl", command = "setfiletype wesl" }
)
