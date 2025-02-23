local dap_ok, dap = pcall(require, "dap")
local dap_ui_ok, dapui = pcall(require, "dapui")

if not (dap_ok and dap_ui_ok) then
  require "notify"("nvim-dap or dap-ui not installed!", "warning")
  return
end

-- have UI open when debugging starts
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

-- UI configurations
dapui.setup {
  icons = { expanded = "▾", collapsed = "▸" },
  mappings = {
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  expand_lines = vim.fn.has "nvim-0.7",
  layouts = {
    {
      elements = {
        "scopes",
      },
      size = 0.3,
      position = "right",
    },
    {
      elements = {
        "repl",
        "breakpoints",
      },
      size = 0.3,
      position = "bottom",
    },
  },
  floating = {
    max_height = nil,
    max_width = nil,
    border = "single",
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
  render = {
    max_type_length = nil,
  },
}

-- nicer looking breakpoints
vim.fn.sign_define(
  "DapBreakpoint",
  { text = "🛑", texthl = "", linehl = "", numhl = "" }
)
vim.fn.sign_define(
  "DapStopped",
  { text = "➤", texthl = "", linehl = "", numhl = "" }
)

-- Language-specific configurations
-- See the nvim-dap documentation for more configurations
-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation

-- Golang
dap.adapters.delve = {
  type = "server",
  port = "${port}",
  executable = {
    command = "dlv",
    args = { "dap", "-l", "127.0.0.1:${port}" },
    -- add this if on windows, otherwise server won't open successfully
    -- detached = false
  },
}

-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
dap.configurations.go = {
  {
    type = "delve",
    name = "Debug",
    request = "launch",
    program = "${file}",
  },
  {
    type = "go",
    name = "Attach (Pick Process)",
    mode = "local",
    request = "attach",
    processId = require("dap.utils").pick_process,
  },
  {
    type = "delve",
    name = "Debug test", -- configuration for debugging test files
    request = "launch",
    mode = "test",
    program = "${file}",
  },
  -- works with go.mod packages and sub packages
  {
    type = "delve",
    name = "Debug test (go.mod)",
    request = "launch",
    mode = "test",
    program = "./${relativeFileDirname}",
  },
  {
    type = "delve",
    name = "Debug main.go with args",
    request = "launch",
    program = "${workspaceFolder}/main.go",
    args = function()
      local args = vim.fn.input "Args: "
      return vim.split(args, " ")
    end,
    cwd = "${workspaceFolder}",
  },
}

-- Python
dap.adapters.python = function(cb, config)
  if config.request == "attach" then
    ---@diagnostic disable-next-line: undefined-field
    local port = (config.connect or config).port
    ---@diagnostic disable-next-line: undefined-field
    local host = (config.connect or config).host or "127.0.0.1"
    cb {
      type = "server",
      port = assert(
        port,
        "`connect.port` is required for a python `attach` configuration"
      ),
      host = host,
      options = {
        source_filetype = "python",
      },
    }
  else
    cb {
      type = "executable",
      command = "/Users/micahkepe/anaconda3/bin/python",
      args = { "-m", "debugpy.adapter" },
      options = {
        source_filetype = "python",
      },
    }
  end
end

dap.configurations.python = {
  {
    type = "python",
    request = "launch",
    name = "Launch file",

    -- Options below are for debugpy, see:
    --  https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings

    program = "${file}", -- This configuration will launch the current file if used.
    pythonPath = function()
      -- debugpy supports launching an application with a different
      -- interpreter then the one used to launch debugpy itself. The code
      -- below looks for a `venv` or `.venv` folder in the current directly
      -- and uses the python within. You could adapt this - to for example
      -- use the `VIRTUAL_ENV` environment variable.
      local cwd = vim.fn.getcwd()
      if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
        return cwd .. "/venv/bin/python"
      elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
        return cwd .. "/.venv/bin/python"
      else
        return "/usr/bin/python3"
      end
    end,
  },
  {
    type = "python",
    request = "launch",
    --  for supported options
    name = "Launch file with arguments",
    program = "${file}",
    args = function()
      local args = vim.fn.input "Args: "
      return vim.split(args, " ")
    end,
    pythonPath = function()
      local cwd = vim.fn.getcwd()
      if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
        return cwd .. "/venv/bin/python"
      elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
        return cwd .. "/.venv/bin/python"
      else
        return "/usr/bin/python3"
      end
    end,
  },
}

-- C/C++/Rust
-- Taken/adapted from:
--  https://github.com/mfussenegger/nvim-dap/wiki/C-C---Rust-(via--codelldb)
--
--  NOTE: To install codelldb and make it executable:
--
--  1. Install the latest codelldb release:
--    https://github.com/vadimcn/codelldb/releases
--
--  2. Unzip and move the executable to your local bin:
--    ```bash
--    unzip codelldb*.vsix
--    chmod + codelldb
--    mv codelldb ~/.local/bin/
--    ```
--  3. In System Settings, make sure that in the privacy and security settings
--    that you enable `codelldb` to be opened.
--
--  4. Add your local bin to your PATH:
--
--    Zsh/Bash:
--
--    ```bash
--    export PATH="$HOME/.local/bin:$PATH"
--    ```
--
--    Fish:
--
--    ```fish
--    set -gx PATH \
--        /opt/homebrew/bin \
--        .
--        .
--        .
--        $HOME/.local/bin \
--        $PATH
--    ```
-- 5. Make sure that you also have `lldb` and `llvm`:
--
--    ```brew
--    brew install lldb
--    brew install llvm
--    ```
--
--    Additionally, make these libraries available to your shell:
--
--    Bash/Zsh:
--
--    ```bash
--    export LIBLLDB_PATH="/opt/homebrew/opt/llvm/lib/liblldb.dylib"
--    export DYLD_LIBRARY_PATH="$(dirname $LIBLLDB_PATH):$DYLD_LIBRARY_PATH"`
--    ```
--
--    Fish:
--
--    ```bash
--    set -gx LIBLLDB_PATH /opt/homebrew/opt/llvm/lib/liblldb.dylib
--    set -g DYLD_LIBRARY_PATH (dirname $LIBLLDB_PATH) $DYLD_LIBRARY_PATH
--
dap.adapters.codelldb = {
  type = "executable",
  command = "codelldb", -- ensure in $PATH
}

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input(
        "Path to executable: ",
        vim.fn.getcwd() .. "/",
        "file"
      )
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

-- add more configurations for other languages here
