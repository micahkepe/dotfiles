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

autocmd("FileType", { pattern = "rust", command = "setl colorcolumn=100" })

autocmd("CursorHold", {
  desc = "Open diagnostics menu on CursorHold",
  callback = function()
    vim.diagnostic.open_float { focus = false }
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

-- Enable treesitter highlighting on file open
-- See: https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#highlighting
autocmd("FileType", {
  callback = function(args)
    -- Disable on large files
    local max_filesize = 100 * 1024 -- 100 KB
    local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(args.buf))
    if ok and stats and stats.size > max_filesize then
      return
    end
    pcall(vim.treesitter.start)
  end,
})

-- Codelens goodies (:h grx)
autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client:supports_method "textDocument/codeLens" then
      vim.lsp.codelens.enable(true, { bufnr = args.buf })
    end
  end,
})
