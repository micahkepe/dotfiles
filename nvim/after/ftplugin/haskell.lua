-- ~/.config/nvim/after/ftplugin/haskell.lua
local ht = require "haskell-tools"
local bufnr = vim.api.nvim_get_current_buf()
local opts = { noremap = true, silent = true, buffer = bufnr }
local map = vim.keymap.set

---Extend the opts table with a description.
---
---See `:h nvim_set_keymap`
---@param desc string
---@return vim.keymap.set.Opts
local function with_desc(desc)
  return vim.tbl_extend("force", opts, { desc = desc })
end

-- haskell-language-server relies heavily on codeLenses,
-- so auto-refresh (see advanced configuration) is enabled by default
map("n", "<space>cl", vim.lsp.codelens.run, with_desc "Run CodeLens")

map(
  "n",
  "<space>Hs",
  function()
    ht.hoogle.hoogle_signature { mode = "browser" }
  end,
  with_desc "Hoogle search for the type signature of the definition under the cursor"
)

map(
  "n",
  "<space>ea",
  ht.lsp.buf_eval_all,
  with_desc "Evaluate all code snippets"
)

map(
  "n",
  "<leader>rr",
  ht.repl.toggle,
  with_desc "Toggle a GHCi repl for the current package"
)

map("n", "<leader>rf", function()
  ht.repl.toggle(vim.api.nvim_buf_get_name(0))
end, with_desc "Toggle a GHCi repl for the current buffer")

map("n", "<leader>rq", ht.repl.quit, with_desc "Quit GHCi REPL")
