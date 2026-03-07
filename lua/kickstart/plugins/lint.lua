return {

  { -- Linting
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'

      -- Debounce lint calls during real-time editing to avoid excessive runs
      local debounce_timer = assert(vim.uv.new_timer())
      local function debounce(func)
        return function(...)
          local args = { ... }
          debounce_timer:stop()
          debounce_timer:start(100, 0, function()
            vim.schedule(function() func(unpack(args)) end)
          end)
        end
      end

      -- Find the best available eslint variant: eslint_d (preferred), then eslint as fallback.
      -- Checks local node_modules first, then global/Mason installs.
      local function find_eslint()
        local candidates = {
          { cmd = './node_modules/.bin/eslint_d', name = 'eslint_d' },
          { cmd = 'eslint_d', name = 'eslint_d' },
          { cmd = './node_modules/.bin/eslint', name = 'eslint' },
          { cmd = 'eslint', name = 'eslint' },
        }
        for _, c in ipairs(candidates) do
          if vim.fn.executable(c.cmd) == 1 then return c.cmd, c.name end
        end
        return nil, nil
      end

      -- Base linter configuration
      lint.linters_by_ft = {}

      -- Only add markdownlint if it's available
      if vim.fn.executable 'markdownlint' == 1 then lint.linters_by_ft.markdown = { 'markdownlint' } end

      if vim.fn.executable 'ruff' == 1 then lint.linters_by_ft.python = { 'ruff' } end

      local eslint_cmd, eslint_name = find_eslint()
      if eslint_cmd then
        lint.linters[eslint_name].cmd = eslint_cmd
        local js_fts = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' }
        for _, ft in ipairs(js_fts) do
          lint.linters_by_ft[ft] = { eslint_name }
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

      -- Skip read-only buffers (e.g. LSP hover popups) to avoid superfluous noise
      local function try_lint_if_modifiable()
        if vim.bo.modifiable then lint.try_lint() end
      end

      local debounced_lint = debounce(try_lint_if_modifiable)

      -- Create autocommand which carries out the actual linting
      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })

      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave', 'CursorHold', 'CursorHoldI' }, {
        group = lint_augroup,
        callback = try_lint_if_modifiable,
      })

      vim.api.nvim_create_autocmd({ 'TextChanged', 'TextChangedI' }, {
        group = lint_augroup,
        callback = debounced_lint,
      })
    end,
  },
}
