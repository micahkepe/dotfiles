-- vimtex setup
vim.g.vimtex_view_method = "sioyek"
vim.g.vimtex_quickfix_mode = 0
vim.g.tex_conceal = "abdmg"

-- Autocommands for VimTeX
vim.api.nvim_create_augroup("VimTeX", {})

-- Clean auxiliary files when compilation stops
vim.api.nvim_create_autocmd("User", {
  group = "VimTeX",
  pattern = "VimtexEventCompileStopped",
  desc = "VimTeX: Clean up auxiliary files on exit",
  command = "VimtexClean",
})

vim.api.nvim_create_autocmd("User", {
  group = vim.api.nvim_create_augroup("VimTeX", { clear = true }),
  pattern = "VimtexEventViewReverse",
  callback = function()
    -- Center text vertically
    vim.cmd "normal! zz"

    -- Move cursor to the last column
    vim.fn.cursor(".", vim.fn.col "$")

    -- Focus back to Kitty window
    os.execute "kitty @ focus-window"
  end,
  desc = "VimTeX: Handle inverse search and return focus to Kitty",
})

-- Auto replace double quotes in LaTeX
vim.api.nvim_create_autocmd("InsertLeave", {
  group = "VimTeX",
  pattern = { "*.tex", "*.bib" },
  desc = "VimTeX: Auto replace double quotes in current line with `` and ''",
  callback = function()
    local line, linenr = vim.fn.getline ".", vim.fn.line "."
    local position = vim.api.nvim_win_get_cursor(0)[2] + 1
    local _, quote_count = string.sub(line, 1, position):gsub('"', "")
    vim.cmd 'silent! %s/\\"\\([^\\"]*\\)\\"/\\`\\`\\1\'\'/'
    local new_line = vim.fn.getline(linenr)
    if line ~= new_line then
      vim.fn.cursor { linenr, position + quote_count }
    end
  end,
})
