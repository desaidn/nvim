-- debug.lua
--
-- Debug Adapter Protocol (DAP) configuration for multiple environments:
-- - Go (delve)
-- - Node.js (js-debug-adapter)
-- - Browser/Chrome (js-debug-adapter)
-- - JVM: Java, Kotlin (java-debug-adapter)

return {
  'mfussenegger/nvim-dap',
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'mason-org/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Language-specific debugger plugins
    'leoluz/nvim-dap-go',
  },
  keys = {
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
      desc = 'Debug: Set Breakpoint',
    },
    {
      '<F7>',
      function()
        require('dapui').toggle()
      end,
      desc = 'Debug: See last session result.',
    },
    {
      '<leader>dl',
      function()
        require('dap').run_last()
      end,
      desc = 'Debug: Run Last',
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
      desc = 'Debug: Terminate',
    },
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      automatic_installation = true,
      handlers = {},
      ensure_installed = {
        'delve', -- Go
        'js', -- JavaScript/TypeScript (js-debug-adapter)
        'javadbg', -- Java Debug Adapter
        'javatest', -- Java Test Runner
      },
    }

    -- Dap UI setup
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

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Go debugging
    require('dap-go').setup {
      delve = {
        detached = vim.fn.has 'win32' == 0,
      },
    }

    -- JavaScript/TypeScript Debug Adapter (js-debug-adapter)
    -- Supports Node.js and browser debugging
    local js_debug_adapter_path = vim.fn.stdpath 'data' .. '/mason/packages/js-debug-adapter'
    local js_debug_adapter_entry = js_debug_adapter_path .. '/js-debug/src/dapDebugServer.js'

    -- Check if the adapter exists
    if vim.fn.filereadable(js_debug_adapter_entry) == 1 then
      -- Node.js adapter
      dap.adapters['pwa-node'] = {
        type = 'server',
        host = 'localhost',
        port = '${port}',
        executable = {
          command = 'node',
          args = { js_debug_adapter_entry, '${port}' },
        },
      }

      -- Chrome adapter (for browser debugging)
      dap.adapters['pwa-chrome'] = {
        type = 'server',
        host = 'localhost',
        port = '${port}',
        executable = {
          command = 'node',
          args = { js_debug_adapter_entry, '${port}' },
        },
      }

      -- Node.js configurations
      dap.configurations.javascript = {
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Launch file',
          program = '${file}',
          cwd = '${workspaceFolder}',
        },
        {
          type = 'pwa-node',
          request = 'attach',
          name = 'Attach to process',
          processId = require('dap.utils').pick_process,
          cwd = '${workspaceFolder}',
        },
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Launch with npm',
          runtimeExecutable = 'npm',
          runtimeArgs = { 'run-script', 'debug' },
          cwd = '${workspaceFolder}',
          console = 'integratedTerminal',
        },
      }

      dap.configurations.typescript = {
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Launch file (ts-node)',
          program = '${file}',
          cwd = '${workspaceFolder}',
          runtimeExecutable = 'ts-node',
          sourceMaps = true,
          resolveSourceMapLocations = {
            '${workspaceFolder}/**',
            '!**/node_modules/**',
          },
        },
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Launch compiled JS',
          program = '${workspaceFolder}/dist/${fileBasenameNoExtension}.js',
          cwd = '${workspaceFolder}',
          sourceMaps = true,
          outFiles = { '${workspaceFolder}/dist/**/*.js' },
        },
        {
          type = 'pwa-node',
          request = 'attach',
          name = 'Attach to process',
          processId = require('dap.utils').pick_process,
          cwd = '${workspaceFolder}',
          sourceMaps = true,
        },
      }

      -- Browser/Chrome configurations
      dap.configurations.javascriptreact = {
        {
          type = 'pwa-chrome',
          request = 'launch',
          name = 'Launch Chrome (localhost:3000)',
          url = 'http://localhost:3000',
          webRoot = '${workspaceFolder}',
          sourceMaps = true,
        },
        {
          type = 'pwa-chrome',
          request = 'attach',
          name = 'Attach to Chrome',
          port = 9222,
          webRoot = '${workspaceFolder}',
          sourceMaps = true,
        },
      }

      dap.configurations.typescriptreact = dap.configurations.javascriptreact

      -- Also add browser debugging for plain JS/TS files
      table.insert(dap.configurations.javascript, {
        type = 'pwa-chrome',
        request = 'launch',
        name = 'Launch Chrome (localhost:3000)',
        url = 'http://localhost:3000',
        webRoot = '${workspaceFolder}',
        sourceMaps = true,
      })

      table.insert(dap.configurations.typescript, {
        type = 'pwa-chrome',
        request = 'launch',
        name = 'Launch Chrome (localhost:3000)',
        url = 'http://localhost:3000',
        webRoot = '${workspaceFolder}',
        sourceMaps = true,
      })
    end

    -- Java Debug Adapter
    local java_debug_path = vim.fn.stdpath 'data' .. '/mason/packages/java-debug-adapter'
    local java_debug_jar = java_debug_path .. '/extension/server/com.microsoft.java.debug.plugin-*.jar'

    dap.adapters.java = function(callback)
      callback {
        type = 'server',
        host = '127.0.0.1',
        port = 5005,
      }
    end

    dap.configurations.java = {
      {
        type = 'java',
        request = 'attach',
        name = 'Attach to running JVM (port 5005)',
        hostName = '127.0.0.1',
        port = 5005,
      },
      {
        type = 'java',
        request = 'launch',
        name = 'Launch Java file',
        mainClass = function()
          return vim.fn.input('Main class: ', '', 'file')
        end,
        projectName = function()
          return vim.fn.input 'Project name: '
        end,
      },
    }

    -- Kotlin uses the same Java debugger
    dap.configurations.kotlin = dap.configurations.java
  end,
}
