return {
  "mrcjkb/rustaceanvim",
  version = "^8",
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
              -- Uncomment for when working with Wasm
              -- target = "wasm32-unknown-unknown",
            },
            check = {
              command = "clippy",
              workspace = false,
              -- Uncomment to for larger repositories since clippy is slower than check
              -- command = "check",
              -- workspace = false,
            },
          },
        },
      },
    }
  end,
}
