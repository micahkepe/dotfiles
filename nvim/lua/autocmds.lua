local autocmd = vim.api.nvim_create_autocmd

autocmd("TermOpen", {
  desc = "Disable spelling on terminal opening event.",
  pattern = "*",
  callback = function()
    vim.opt_local.spell = false
  end,
})

autocmd("CursorHold", {
  desc = "Open diagnostics menu on CursorHold",
  callback = function()
    vim.diagnostic.open_float(nil, { focus = false })
  end,
})

autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})
