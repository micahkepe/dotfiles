-- vimtex setup
vim.g.vimtex_view_method = "sioyek"
vim.g.vimtex_quickfix_mode = 0
vim.g.tex_conceal = "abdmg" -- Conceal some LaTeX code
vim.g.matchup_override_vimtex = 1
vim.g.vimtex_indent_on_ampersands = 0

-- Documentation reference:
--  https://us.mirrors.cicku.me/ctan/support/latexmk/latexmk.pdf
vim.g.vimtex_compiler_latexmk = {
  options = {
    "-shell-escape",
    "-pdf",
    "-pdflatex",
    "-interaction=nonstopmode", -- Prevents LaTeX from stopping on errors
    "-synctex=1", -- Enables forward/inverse search with sioyek
    "-file-line-error", -- Shows errors with file and line number
    "-quiet", -- Less aggressive than -silent, keeps critical warnings
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
