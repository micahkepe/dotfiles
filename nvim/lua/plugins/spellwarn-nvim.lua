return {
  "ravibrock/spellwarn.nvim",
  event = "VeryLazy",
  config = function()
    require("spellwarn").setup {
      enable = false, -- disable diagnostics on startup
      ft_config = {
        gitcommit = false,

        -- CUSTOM FILETYPES
        -- `log` filetype
        -- Add this to your `init.lua`:
        --
        --    vim.filetype.add {
        --      extension = {
        --        log = "log", -- This sets the filetype for .log files
        --      },
        --    }
        --
        log = false,
      },
      ft_default = true,
    }
  end,
}
