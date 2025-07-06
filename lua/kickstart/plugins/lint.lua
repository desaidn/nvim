return {

  { -- Linting
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'

      -- Function to find available ESLint executable
      local function find_eslint()
        -- Check for local project ESLint first
        if vim.fn.executable './node_modules/.bin/eslint' == 1 then
          return './node_modules/.bin/eslint'
        end
        -- Check for global ESLint from Mason
        if vim.fn.executable 'eslint' == 1 then
          return 'eslint'
        end
        return nil
      end

      -- Base linter configuration
      lint.linters_by_ft = {}

      -- Only add markdownlint if it's available
      if vim.fn.executable 'markdownlint' == 1 then
        lint.linters_by_ft.markdown = { 'markdownlint' }
      end

      -- Only add ESLint if it's available
      local eslint_cmd = find_eslint()
      if eslint_cmd then
        lint.linters.eslint.cmd = eslint_cmd
        lint.linters_by_ft.javascript = { 'eslint' }
        lint.linters_by_ft.javascriptreact = { 'eslint' }
        lint.linters_by_ft.typescript = { 'eslint' }
        lint.linters_by_ft.typescriptreact = { 'eslint' }
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

      -- Create autocommand which carries out the actual linting
      -- on the specified events.
      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          -- Only run the linter in buffers that you can modify in order to
          -- avoid superfluous noise, notably within the handy LSP pop-ups that
          -- describe the hovered symbol using Markdown.
          if vim.bo.modifiable then
            lint.try_lint()
          end
        end,
      })
    end,
  },
}
