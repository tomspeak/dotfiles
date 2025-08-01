return {
  'stevearc/conform.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    notify_on_error = false,
    formatters_by_ft = {},
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
  },
}
