return {
  'stevearc/conform.nvim',
  event = 'BufWritePre',
  keys = {
    {
      '<leader>fm',
      function()
        require('conform').format { timeout_ms = 1000, lsp_format = 'fallback' }
      end,
      desc = '[F]or[m]at buffer',
    },
    {
      '<leader>tf',
      function()
        vim.b.disable_autoformat = not vim.b.disable_autoformat
        vim.notify('Format on save: ' .. (vim.b.disable_autoformat and 'off' or 'on'))
      end,
      desc = '[T]oggle [F]ormat on save (buffer)',
    },
  },
  opts = {
    notify_on_error = false,
    formatters_by_ft = {
      lua = { 'stylua' },
      sh = { 'shfmt' },
    },
    format_on_save = function(bufnr)
      if vim.b[bufnr].disable_autoformat then
        return
      end
      return { timeout_ms = 1000, lsp_format = 'fallback' }
    end,
  },
}
