--- Toggle indent-based folding on the current file buffer. When enabled, the JSON object
--- will be folded based on indents, where all folds with a depth > 1 are closed (e.g., starting
--- from secondary JSON objects). Toggling off will reopen all closed folds and revert to manual
--- folding.
local function toggle_json_folding()
  if
    vim.api.nvim_get_option_value("foldmethod", { scope = "local" }) == "manual"
  then
    -- Enable folding
    vim.api.nvim_set_option_value("foldmethod", "indent", { scope = "local" })
    vim.api.nvim_set_option_value("foldlevel", 1, { scope = "local" })
    vim.api.nvim_set_option_value("foldnestmax", 4, { scope = "local" })
  else
    -- Revert to manual folding and default values
    vim.api.nvim_set_option_value("foldmethod", "manual", { scope = "local" })
    vim.api.nvim_set_option_value("foldlevel", 0, { scope = "local" })
    vim.api.nvim_set_option_value("foldnestmax", 20, { scope = "local" })
    vim.cmd "norm! zR" -- open all folds recursively
  end
end

vim.api.nvim_create_user_command(
  "ToggleJsonFolding",
  toggle_json_folding,
  { desc = "Toggle indent-based folding on the current JSON file buffer" }
)
