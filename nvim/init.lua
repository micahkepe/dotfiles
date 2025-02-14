vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    repo,
    "--branch=stable",
    lazypath,
  }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
    config = function()
      require "options"
      -- Override nvim-tree settings
      local nvim_tree_options = require "nvchad.configs.nvimtree"
      nvim_tree_options.filters.dotfiles = false
      nvim_tree_options.git = { enable = true }
      nvim_tree_options.filters.git_ignored = false
      nvim_tree_options.filters.custom =
        { "^\\.git$", "DS_Store", "^\\.godot$" }
    end,
  },

  { import = "plugins" },
}, lazy_config)

-- disable Copilot on startup
vim.cmd "Copilot disable"

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

-- allow external applications to connect to Neovim
-- taken from: https://ericlathrop.com/2024/02/configuring-neovim-s-lsp-to-work-with-godot/
local pipepath = vim.fn.stdpath "cache" .. "/server.pipe"
if not vim.loop.fs_stat(pipepath) then
  vim.fn.serverstart(pipepath)
end
