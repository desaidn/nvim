-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for multiple environments:
--  - Go (using delve)
--  - Node.js (using js-debug-adapter / vscode-js-debug)
--  - Browser/Chrome (using js-debug-adapter / vscode-js-debug)
--  - JVM: Java, Kotlin (using java-debug-adapter, kotlin-debug-adapter)
--
-- For more information, see:
--  - https://github.com/mfussenegger/nvim-dap
--  - https://github.com/jay-babu/mason-nvim-dap.nvim
--  - https://github.com/rcarriga/nvim-dap-ui
--
-- NOTE: Debug Adapter Protocol (DAP) is a standardized protocol for communication
-- between editors/IDEs and debuggers. nvim-dap is a DAP client for Neovim.

return {
  -- nvim-dap is a Debug Adapter Protocol client implementation for Neovim.
  -- It allows you to debug applications directly from Neovim.
  'mfussenegger/nvim-dap',

  dependencies = {
    -- Creates a beautiful debugger UI with windows for:
    -- watches, breakpoints, call stack, local variables, and more
    'rcarriga/nvim-dap-ui',

    -- Required dependency for nvim-dap-ui (async I/O library)
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you via Mason
    -- This integrates Mason with nvim-dap for easy adapter management
    'mason-org/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here. These plugins provide pre-configured
    -- setups for specific languages, reducing boilerplate configuration.
    'leoluz/nvim-dap-go', -- Go debugging with delve
    'mfussenegger/nvim-jdtls', -- Java/Kotlin via Eclipse JDTLS (optional, for enhanced Java support)
  },

  keys = {
    -- Basic debugging keymaps, feel free to change to your liking!
    -- These follow a pattern similar to VS Code defaults
    {
      '<F5>',
      function()
        require('dap').continue()
      end,
      desc = 'Debug: Start/Continue',
    },
    {
      '<F1>',
      function()
        require('dap').step_into()
      end,
      desc = 'Debug: Step Into',
    },
    {
      '<F2>',
      function()
        require('dap').step_over()
      end,
      desc = 'Debug: Step Over',
    },
    {
      '<F3>',
      function()
        require('dap').step_out()
      end,
      desc = 'Debug: Step Out',
    },
    {
      '<leader>b',
      function()
        require('dap').toggle_breakpoint()
      end,
      desc = 'Debug: Toggle Breakpoint',
    },
    {
      '<leader>B',
      function()
        require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end,
      desc = 'Debug: Set Conditional Breakpoint',
    },
    -- Toggle to see last session result. Without this, you can't see session output
    -- in case of unhandled exception.
    {
      '<F7>',
      function()
        require('dapui').toggle()
      end,
      desc = 'Debug: Toggle Debug UI',
    },
    {
      '<leader>dl',
      function()
        require('dap').run_last()
      end,
      desc = 'Debug: Run Last Configuration',
    },
    {
      '<leader>dr',
      function()
        require('dap').repl.open()
      end,
      desc = 'Debug: Open REPL',
    },
    {
      '<leader>dt',
      function()
        require('dap').terminate()
      end,
      desc = 'Debug: Terminate Session',
    },
  },

  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    -- mason-nvim-dap bridges Mason and nvim-dap, making it easy to
    -- install and configure debug adapters.
    --
    -- The `ensure_installed` list uses mason-nvim-dap adapter names,
    -- which map to Mason package names:
    --   'delve'    -> 'delve' (Go debugger)
    --   'js'       -> 'js-debug-adapter' (Node.js/Chrome debugger)
    --   'javadbg'  -> 'java-debug-adapter' (Java debugger)
    --   'javatest' -> 'java-test' (Java test runner)
    --   'kotlin'   -> 'kotlin-debug-adapter' (Kotlin debugger)
    --
    -- For the full mapping, see:
    -- https://github.com/jay-babu/mason-nvim-dap.nvim/blob/main/lua/mason-nvim-dap/mappings/source.lua
    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- Ensure these debug adapters are installed
      ensure_installed = {
        'delve', -- Go
        'js', -- JavaScript/TypeScript (installs js-debug-adapter)
        'javadbg', -- Java (installs java-debug-adapter)
        'javatest', -- Java test runner (installs java-test)
        'kotlin', -- Kotlin (installs kotlin-debug-adapter)
      },
    }

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    -- Icons use unicode characters (no Nerd Font required)
    dapui.setup {
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    -- Automatically open/close the DAP UI when debugging starts/stops
    -- These listeners hook into DAP events to control the UI
    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- ============================================================================
    -- GO DEBUGGING (using delve)
    -- ============================================================================
    -- Install Go debug adapter: :MasonInstall delve
    -- The nvim-dap-go plugin provides pre-configured debugging for Go
    require('dap-go').setup {
      delve = {
        -- On Windows delve must be run attached; on Linux/macOS
        -- it should be detached for proper cleanup
        detached = vim.fn.has 'win32' == 0,
      },
    }

    -- ============================================================================
    -- JAVASCRIPT/TYPESCRIPT DEBUGGING (using js-debug-adapter)
    -- ============================================================================
    -- Install: :MasonInstall js-debug-adapter
    --
    -- js-debug-adapter (vscode-js-debug) supports multiple debug types:
    --   'pwa-node'   - Node.js debugging
    --   'pwa-chrome' - Chrome browser debugging
    --   'pwa-msedge' - Microsoft Edge debugging
    --
    -- For more configuration options, see:
    -- https://github.com/microsoft/vscode-js-debug/blob/main/OPTIONS.md

    -- Path to the js-debug-adapter installed by Mason
    local js_debug_adapter_path = vim.fn.stdpath 'data' .. '/mason/packages/js-debug-adapter'
    local js_debug_adapter_entry = js_debug_adapter_path .. '/js-debug/src/dapDebugServer.js'

    -- Only configure JS debugging if the adapter is installed
    if vim.fn.filereadable(js_debug_adapter_entry) == 1 then
      -- Node.js debug adapter configuration
      -- type = 'server' means nvim-dap will spawn and connect to a debug server
      -- '${port}' is a special variable - nvim-dap picks an available port
      dap.adapters['pwa-node'] = {
        type = 'server',
        host = 'localhost',
        port = '${port}',
        executable = {
          command = 'node',
          args = { js_debug_adapter_entry, '${port}' },
        },
      }

      -- Chrome debug adapter configuration (uses the same js-debug-adapter)
      dap.adapters['pwa-chrome'] = {
        type = 'server',
        host = 'localhost',
        port = '${port}',
        executable = {
          command = 'node',
          args = { js_debug_adapter_entry, '${port}' },
        },
      }

      -- JavaScript debug configurations
      -- These appear in the configuration picker when you start debugging
      dap.configurations.javascript = {
        -- Launch current file in Node.js
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Launch file',
          program = '${file}', -- Current file
          cwd = '${workspaceFolder}',
        },
        -- Attach to a running Node.js process
        -- Start your app with: node --inspect app.js
        {
          type = 'pwa-node',
          request = 'attach',
          name = 'Attach to process',
          processId = require('dap.utils').pick_process, -- Shows process picker
          cwd = '${workspaceFolder}',
        },
        -- Launch via npm script (expects "debug" script in package.json)
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Launch via npm debug script',
          runtimeExecutable = 'npm',
          runtimeArgs = { 'run-script', 'debug' },
          cwd = '${workspaceFolder}',
          console = 'integratedTerminal',
        },
        -- Debug in Chrome browser
        {
          type = 'pwa-chrome',
          request = 'launch',
          name = 'Launch Chrome (localhost:3000)',
          url = 'http://localhost:3000',
          webRoot = '${workspaceFolder}',
          sourceMaps = true,
        },
      }

      -- TypeScript debug configurations
      dap.configurations.typescript = {
        -- Launch TypeScript file directly with ts-node
        -- Requires: npm install -g ts-node
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Launch file (ts-node)',
          program = '${file}',
          cwd = '${workspaceFolder}',
          runtimeExecutable = 'ts-node',
          sourceMaps = true,
          -- Where to look for source maps
          resolveSourceMapLocations = {
            '${workspaceFolder}/**',
            '!**/node_modules/**',
          },
        },
        -- Launch pre-compiled JavaScript (from dist/ folder)
        -- Assumes TypeScript compiles to dist/ with source maps
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Launch compiled JS (dist/)',
          program = '${workspaceFolder}/dist/${fileBasenameNoExtension}.js',
          cwd = '${workspaceFolder}',
          sourceMaps = true,
          outFiles = { '${workspaceFolder}/dist/**/*.js' },
        },
        -- Attach to running TypeScript/Node process
        {
          type = 'pwa-node',
          request = 'attach',
          name = 'Attach to process',
          processId = require('dap.utils').pick_process,
          cwd = '${workspaceFolder}',
          sourceMaps = true,
        },
        -- Debug in Chrome browser
        {
          type = 'pwa-chrome',
          request = 'launch',
          name = 'Launch Chrome (localhost:3000)',
          url = 'http://localhost:3000',
          webRoot = '${workspaceFolder}',
          sourceMaps = true,
        },
      }

      -- React (JSX) debug configurations - primarily browser debugging
      dap.configurations.javascriptreact = {
        {
          type = 'pwa-chrome',
          request = 'launch',
          name = 'Launch Chrome (localhost:3000)',
          url = 'http://localhost:3000',
          webRoot = '${workspaceFolder}',
          sourceMaps = true,
        },
        -- Attach to Chrome running with remote debugging enabled
        -- Start Chrome with: google-chrome --remote-debugging-port=9222
        {
          type = 'pwa-chrome',
          request = 'attach',
          name = 'Attach to Chrome (port 9222)',
          port = 9222,
          webRoot = '${workspaceFolder}',
          sourceMaps = true,
        },
      }

      -- TypeScript React (TSX) uses the same configurations as JSX
      dap.configurations.typescriptreact = dap.configurations.javascriptreact
    end

    -- ============================================================================
    -- JAVA DEBUGGING (using java-debug-adapter)
    -- ============================================================================
    -- Install: :MasonInstall java-debug-adapter java-test
    --
    -- For full Java debugging support, consider using nvim-jdtls which provides
    -- enhanced integration with Eclipse JDTLS and java-debug-adapter.
    -- See: https://github.com/mfussenegger/nvim-jdtls
    --
    -- Basic usage (attach mode):
    -- 1. Start your Java app with debug flags:
    --    java -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005 MyApp
    -- 2. Press <F5> and select "Attach to running JVM"

    -- Java adapter connects to a running JVM debug server
    -- Unlike other adapters, this uses 'attach' mode since the JVM
    -- runs its own debug server via JDWP
    dap.adapters.java = function(callback)
      callback {
        type = 'server',
        host = '127.0.0.1',
        port = 5005, -- Default JDWP port
      }
    end

    -- Java debug configurations
    dap.configurations.java = {
      -- Attach to a running JVM with debugging enabled
      {
        type = 'java',
        request = 'attach',
        name = 'Attach to running JVM (port 5005)',
        hostName = '127.0.0.1',
        port = 5005,
      },
      -- Launch configuration (prompts for main class)
      -- Note: For better launch support, use nvim-jdtls
      {
        type = 'java',
        request = 'launch',
        name = 'Launch Java file',
        mainClass = function()
          return vim.fn.input('Main class (e.g., com.example.Main): ', '', 'file')
        end,
        projectName = function()
          return vim.fn.input 'Project name: '
        end,
      },
    }

    -- ============================================================================
    -- KOTLIN DEBUGGING (using kotlin-debug-adapter)
    -- ============================================================================
    -- Install: :MasonInstall kotlin-debug-adapter
    --
    -- Kotlin runs on the JVM, so it uses a similar debugging approach to Java.
    -- The kotlin-debug-adapter provides Kotlin-specific debugging support.
    --
    -- For unit tests, run with debug enabled:
    --   ./gradlew --info cleanTest test --debug-jvm
    -- Then attach the debugger.

    -- Kotlin adapter configuration
    dap.adapters.kotlin = {
      type = 'executable',
      command = 'kotlin-debug-adapter',
      options = {
        auto_continue_if_many_stopped = false,
      },
    }

    -- Kotlin debug configurations
    dap.configurations.kotlin = {
      -- Launch Kotlin application
      {
        type = 'kotlin',
        request = 'launch',
        name = 'Launch Kotlin Program',
        projectRoot = '${workspaceFolder}',
        mainClass = function()
          return vim.fn.input('Main class (e.g., com.example.MainKt): ', '', 'file')
        end,
      },
      -- Attach to running JVM (Kotlin apps run on JVM)
      {
        type = 'kotlin',
        request = 'attach',
        name = 'Attach to Kotlin/JVM (port 5005)',
        hostName = '127.0.0.1',
        port = 5005,
        timeout = 2000,
      },
    }
  end,
}
