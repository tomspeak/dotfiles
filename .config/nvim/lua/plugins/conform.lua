return {
  'stevearc/conform.nvim',
  event = 'BufWritePre',
  opts = {
    notify_on_error = false,
    format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback",
    },
  },
}
