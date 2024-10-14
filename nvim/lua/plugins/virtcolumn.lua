return {
  "xiyaowong/virtcolumn.nvim",
  event = "BufRead",
  config = function()
    -- Basic configuration
    vim.g.virtcolumn_char = "▕"
    vim.g.virtcolumn_priority = 10

    -- Create a global variable to track the state
    vim.g.virtcolumn_enabled = true

    -- Function to check if virtcolumn should be disabled for current buffer
    -- FIX: this still isn't working for the terminal buffer
    local function should_disable_virtcolumn()
      local buftype = vim.bo.buftype
      local filetype = vim.bo.filetype

      -- List of buffer types and file types to exclude
      local excluded_buftypes = { "terminal", "nofile", "quickfix" }
      local excluded_filetypes = { "NvimTree", "neo-tree", "CHADTree" }

      -- Check if current buffer type is in excluded list
      for _, excluded in ipairs(excluded_buftypes) do
        if buftype == excluded then
          return true
        end
      end

      -- Check if current file type is in excluded list
      for _, excluded in ipairs(excluded_filetypes) do
        if filetype == excluded then
          return true
        end
      end

      return false
    end

    -- Set up autocommand to check buffer type and disable virtcolumn if needed
    vim.api.nvim_create_autocmd({ "BufEnter", "TermOpen", "FileType" }, {
      callback = function()
        if should_disable_virtcolumn() then
          vim.opt_local.colorcolumn = ""
        elseif vim.g.virtcolumn_enabled then
          vim.opt_local.colorcolumn = "80"
        end
      end,
    })

    -- Function to toggle virtcolumn
    vim.g.toggle_virtcolumn = function()
      vim.g.virtcolumn_enabled = not vim.g.virtcolumn_enabled

      if vim.g.virtcolumn_enabled then
        -- Only enable for non-excluded buffers
        if not should_disable_virtcolumn() then
          vim.opt_local.colorcolumn = "80"
          vim.cmd [[runtime plugin/virtcolumn.vim]]
        end
      else
        vim.opt.colorcolumn = ""
        vim.cmd [[augroup VirtColumn | autocmd! | augroup END]]
        vim.cmd [[silent! lua require('virtcolumn').setup_buffer()]]
      end

      vim.notify("VirtColumn " .. (vim.g.virtcolumn_enabled and "enabled" or "disabled"), vim.log.levels.INFO)
    end

    -- Initial setup
    if not should_disable_virtcolumn() then
      vim.opt.colorcolumn = "80"
    end

    vim.cmd [[highlight VirtColumn guifg=#3b4261 gui=nocombine]]
  end,
}
