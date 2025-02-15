-- VimTex setup:
--  Official docs:
--    https://github.com/lervag/vimtex/blob/master/README.md#configuration
--
--  Another resource:
--    https://ejmastnak.com/tutorials/vim-latex/vimtex/

-- Viewer options: One may configure the viewer either by specifying a built-in
-- viewer method:
vim.g.vimtex_view_method = "sioyek"

-- Ensure that forward searching is enabled
vim.g.vimtex_view_forward_search_on_start = 1

vim.g.vimtex_quickfix_mode = 0
vim.g.tex_conceal = "abdmg" -- Conceal some LaTeX code
vim.g.matchup_override_vimtex = 1
vim.g.vimtex_indent_on_ampersands = 1

-- NOTE: VimTeX uses latexmk as the default compiler backend. If you use it,
-- which is strongly recommended, you probably don't need to configure
-- anything. If you want another compiler backend, you can change it as
-- follows. The list of supported backends and further explanation is
-- provided in the documentation, see ":help vimtex-compiler".

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
