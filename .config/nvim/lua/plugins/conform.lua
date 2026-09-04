return {
  'stevearc/conform.nvim',
  event = 'BufWritePre',
  opts = {
    notify_on_error = false,
    formatters_by_ft = {
      lua = { 'stylua' },
      sh = { 'shfmt' },
    },
    format_on_save = {
      timeout_ms = 1000,
      lsp_format = 'fallback',
    },
  },
}
