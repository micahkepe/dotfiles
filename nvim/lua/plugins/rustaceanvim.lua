return {
  "mrcjkb/rustaceanvim",
  version = "^6",
  ft = "rust",
  init = function()
    -- Default config:
    --   https://github.com/mrcjkb/rustaceanvim/blob/6bd02e97a1f3102f06a72726764f24d3b3a33a85/lua/rustaceanvim/config/internal.lua#L94
    vim.g.rustaceanvim = {
      server = {
        default_settings = {
          -- https://rust-analyzer.github.io/book/configuration
          ["rust-analyzer"] = {
            cargo = {
              features = "all",
            },
            check = {
              command = "clippy",
            },
          },
        },
      },
    }
  end,
}
