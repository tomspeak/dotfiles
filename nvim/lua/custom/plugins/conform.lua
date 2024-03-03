return {
  'stevearc/conform.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    notify_on_error = false,
    formatters_by_ft = {
      lua = { 'stylua' },
      rust = { 'rustfmt' },
      javascript = { 'prettierd' },
      javascriptreact = { 'prettierd' },
      typescript = { 'prettierd' },
      typescriptreact = { 'prettierd' },
      css = { 'prettierd' },
      html = { 'prettierd' },
      json = { 'prettierd' },
      sh = { 'shfmt' },
      go = { 'gofumpt', 'goimports' },
      proto = { 'buf' },
      toml = { 'taplo' },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = false,
    },
  },
}
