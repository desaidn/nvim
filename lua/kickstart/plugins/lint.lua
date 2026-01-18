return {

  { -- Linting
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'

      -- Configuration: Set to false to disable fallback to regular eslint
      local ESLINT_FALLBACK_ENABLED = false

      -- Real-time linting configuration
      local REAL_TIME_LINTING_ENABLED = true
      local LINT_DEBOUNCE_MS = 100

      -- Debounce utility function using vim.uv.new_timer
      local function debounce(func, delay)
        local timer = vim.uv.new_timer()
        return function(...)
          local args = { ... }
          timer:stop()
          timer:start(delay, 0, function()
            vim.schedule(function()
              func(unpack(args))
            end)
          end)
        end
      end

      -- Function to find available ESLint daemon with configurable fallback
      local function find_eslint_d()
        -- Check for local project eslint_d first
        if vim.fn.executable './node_modules/.bin/eslint_d' == 1 then
          return './node_modules/.bin/eslint_d'
        end
        -- Check for global eslint_d from Mason
        if vim.fn.executable 'eslint_d' == 1 then
          return 'eslint_d'
        end

        -- Fallback behavior based on configuration
        if ESLINT_FALLBACK_ENABLED then
          -- Check for local project eslint
          if vim.fn.executable './node_modules/.bin/eslint' == 1 then
            return './node_modules/.bin/eslint'
          end
          -- Check for global eslint from Mason
          if vim.fn.executable 'eslint' == 1 then
            return 'eslint'
          end
        end

        return nil -- No linter available or fallback disabled
      end

      -- Base linter configuration
      lint.linters_by_ft = {}

      -- Only add markdownlint if it's available
      if vim.fn.executable 'markdownlint' == 1 then
        lint.linters_by_ft.markdown = { 'markdownlint' }
      end

      -- Only add ESLint daemon if it's available
      local eslint_cmd = find_eslint_d()
      local using_eslint_d = false
      if eslint_cmd then
        -- Configure the linter based on what we found
        if eslint_cmd:match 'eslint_d' then
          -- Using eslint_d - configure eslint_d linter
          using_eslint_d = true
          lint.linters.eslint_d.cmd = eslint_cmd
          lint.linters_by_ft.javascript = { 'eslint_d' }
          lint.linters_by_ft.javascriptreact = { 'eslint_d' }
          lint.linters_by_ft.typescript = { 'eslint_d' }
          lint.linters_by_ft.typescriptreact = { 'eslint_d' }
        else
          -- Fallback to regular eslint
          lint.linters.eslint.cmd = eslint_cmd
          lint.linters_by_ft.javascript = { 'eslint' }
          lint.linters_by_ft.javascriptreact = { 'eslint' }
          lint.linters_by_ft.typescript = { 'eslint' }
          lint.linters_by_ft.typescriptreact = { 'eslint' }
        end
      end

      -- To allow other plugins to add linters to require('lint').linters_by_ft,
      -- instead set linters_by_ft like this:
      -- lint.linters_by_ft = lint.linters_by_ft or {}
      -- lint.linters_by_ft['markdown'] = { 'markdownlint' }
      --
      -- However, note that this will enable a set of default linters,
      -- which will cause errors unless these tools are available:
      -- {
      --   clojure = { "clj-kondo" },
      --   dockerfile = { "hadolint" },
      --   inko = { "inko" },
      --   janet = { "janet" },
      --   json = { "jsonlint" },
      --   markdown = { "vale" },
      --   rst = { "vale" },
      --   ruby = { "ruby" },
      --   terraform = { "tflint" },
      --   text = { "vale" }
      -- }
      --
      -- You can disable the default linters by setting their filetypes to nil:
      -- lint.linters_by_ft['clojure'] = nil
      -- lint.linters_by_ft['dockerfile'] = nil
      -- lint.linters_by_ft['inko'] = nil
      -- lint.linters_by_ft['janet'] = nil
      -- lint.linters_by_ft['json'] = nil
      -- lint.linters_by_ft['markdown'] = nil
      -- lint.linters_by_ft['rst'] = nil
      -- lint.linters_by_ft['ruby'] = nil
      -- lint.linters_by_ft['terraform'] = nil
      -- lint.linters_by_ft['text'] = nil

      -- Create lint function with modifiable buffer check
      local function try_lint_if_modifiable()
        -- Only run the linter in buffers that you can modify in order to
        -- avoid superfluous noise, notably within the handy LSP pop-ups that
        -- describe the hovered symbol using Markdown.
        if vim.bo.modifiable then
          lint.try_lint()
        end
      end

      -- Create debounced version for real-time events
      local debounced_lint = debounce(try_lint_if_modifiable, LINT_DEBOUNCE_MS)

      -- Create autocommand which carries out the actual linting
      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })

      -- Immediate linting events (no debounce needed)
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = try_lint_if_modifiable,
      })

      -- Real-time linting events (with debounce) - only for stdin-compatible linters
      if REAL_TIME_LINTING_ENABLED and using_eslint_d then
        vim.api.nvim_create_autocmd({ 'TextChanged', 'TextChangedI' }, {
          group = lint_augroup,
          callback = debounced_lint,
        })

        -- Also lint when cursor stops moving (useful for catching errors after navigation)
        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
          group = lint_augroup,
          callback = try_lint_if_modifiable,
        })
      end
    end,
  },
}
