-- vimtex setup
vim.g.vimtex_view_method = "sioyek"
vim.g.vimtex_quickfix_mode = 0
vim.g.tex_conceal = "abdmg"

-- Enable shell-escape for VimTeX (needed for minted)
vim.g.vimtex_compiler_latexmk = {
  options = {
    "-shell-escape", -- Enable shell escape for minted
    "-verbose",
    "-file-line-error",
    "-synctex=1",
    "-interaction=nonstopmode",
  },
}

-- Autocommands for VimTeX
vim.api.nvim_create_augroup("VimTeX", {})

-- Clean auxiliary files when compilation stops
vim.api.nvim_create_autocmd("User", {
  group = "VimTeX",
  pattern = "VimtexEventCompileStopped",
  desc = "VimTeX: Clean up auxiliary files on exit",
  command = "VimtexClean",
})
