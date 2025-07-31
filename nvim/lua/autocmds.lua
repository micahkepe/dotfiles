local autocmd = vim.api.nvim_create_autocmd

autocmd("TermOpen", {
  desc = "Disable spelling and colorcolumn on terminal opening event.",
  callback = function()
    vim.opt_local.spell = false
    -- NOTE: use schedule to queue for next iteration of the main event loop
    -- For some reason this option cannot be set immediately when I try
    vim.schedule(function()
      vim.cmd 'setl cc=""'
    end)
  end,
})

autocmd("Filetype", { pattern = "rust", command = "setl colorcolumn=100" })

autocmd("CursorHold", {
  desc = "Open diagnostics menu on CursorHold",
  callback = function()
    vim.diagnostic.open_float(nil, { focus = false })
  end,
})

autocmd("TextYankPost", {
  pattern = "*",
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})
