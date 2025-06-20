vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    lazyrepo,
    lazypath,
  }
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
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
      nvim_tree_options.filters.custom = { "^\\.git$", "DS_Store" }
    end,
  },

  -- Disable telescope (migrated to snacks)
  {
    "nvim-telescope/telescope.nvim",
    enabled = false,
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "nvchad.autocmds"
require "autocmds" -- additional autocommands

vim.schedule(function()
  require "mappings"
end)

-- allow external applications to connect to Neovim
-- taken from: https://ericlathrop.com/2024/02/configuring-neovim-s-lsp-to-work-with-godot/
local pipepath = vim.fn.stdpath "cache" .. "/server.pipe"
if not vim.loop.fs_stat(pipepath) then
  vim.fn.serverstart(pipepath)
end
