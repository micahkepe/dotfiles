-- automatically creates a Vim session when Neovim opens for saving work
return {
  "rmagatti/auto-session",
  event = "BufRead", -- Load on first buffer read
  config = function()
    local auto_session = require "auto-session"
    auto_session.setup {
      auto_restore_enabled = false,
      auto_session_suppress_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/" },
    }

    -- Define keymaps after setup
    vim.keymap.set("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "Restore session for cwd" })
    vim.keymap.set("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "Save session for auto session root dir" })
  end,
}
