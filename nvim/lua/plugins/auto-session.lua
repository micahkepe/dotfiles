-- automatically creates a Vim session when Neovim opens for saving work
return {
  "rmagatti/auto-session",
  lazy = false,
  config = function()
    local auto_session = require "auto-session"
    auto_session.setup {
      auto_restore = false,
      suppressed_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/" },
    }
  end,
}
