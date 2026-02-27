return {
  "junegunn/goyo.vim",
  cmd = "Goyo",
  config = function()
    -- Tell Goyo not to hide line numbers (it checks this in s:hide_linenr)
    vim.g.goyo_linenr = 1

    local saved_opts = {}

    vim.api.nvim_create_autocmd("User", {
      pattern = "GoyoEnter",
      callback = function()
        saved_opts = {
          wrap = vim.o.wrap,
          linebreak = vim.o.linebreak,
          textwidth = vim.o.textwidth,
          tabcount = vim.fn.tabpagenr "$",
        }
        vim.o.wrap = true
        vim.o.linebreak = true
        vim.o.textwidth = 0
        vim.wo.number = true
        vim.wo.relativenumber = true

        -- Map <leader>x to exit Goyo
        vim.keymap.set("n", "<leader>x", "<cmd>Goyo!<CR>", { buffer = true })

        -- Remove ibl's ColorScheme autocmd before Goyo exits, because
        -- goyo_off resets the colorscheme (triggering ColorScheme event)
        -- before NvChad's base46 highlights are restored, causing ibl
        -- to crash on missing IblChar highlight group.
        pcall(vim.api.nvim_clear_autocmds, {
          group = "IndentBlankline",
          event = "ColorScheme",
        })
      end,
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = "GoyoLeave",
      callback = function()
        vim.o.wrap = saved_opts.wrap
        vim.o.linebreak = saved_opts.linebreak
        vim.o.textwidth = saved_opts.textwidth

        -- Close any extra tabs Goyo left behind
        while vim.fn.tabpagenr "$" > saved_opts.tabcount do
          vim.cmd "tabclose"
        end

        -- Reload NvChad highlights (clears the colorscheme damage),
        -- then re-setup ibl autocmds so ColorScheme works again.
        require("base46").load_all_highlights()
        require("ibl.autocmds").setup()
      end,
    })
  end,
}
