return {

  { -- Linting
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'

      -- Base linter configuration
      lint.linters_by_ft = {}

      -- Only add linters if they're available
      if vim.fn.executable 'markdownlint' == 1 then lint.linters_by_ft.markdown = { 'markdownlint' } end

      if vim.fn.executable 'ruff' == 1 then lint.linters_by_ft.python = { 'ruff' } end

      if vim.fn.executable 'eslint_d' == 1 then
        local js_fts = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' }
        for _, ft in ipairs(js_fts) do
          lint.linters_by_ft[ft] = { 'eslint_d' }
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

      -- Create autocommand which carries out the actual linting
      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })

      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave', 'CursorHold', 'CursorHoldI' }, {
        group = lint_augroup,
        callback = try_lint_if_modifiable,
      })

      -- Debounce lint calls during real-time editing to avoid excessive runs
      local debounce_timer = assert(vim.uv.new_timer())
      vim.api.nvim_create_autocmd({ 'TextChanged', 'TextChangedI' }, {
        group = lint_augroup,
        callback = function()
          debounce_timer:stop()
          debounce_timer:start(100, 0, function()
            vim.schedule(try_lint_if_modifiable)
          end)
        end,
      })
    end,
  },
}
