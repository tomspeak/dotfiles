return {
  'stevearc/conform.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    notify_on_error = false,
    formatters_by_ft = {
      css = { 'prettierd' },
      go = { 'gofumpt', 'goimports' },
      html = { 'prettierd' },
      javascript = { 'prettierd' },
      javascriptreact = { 'prettierd' },
      json = { 'prettierd' },
      lua = { 'stylua' },
      markdown = { 'prettierd' },
      proto = { 'buf' },
      rust = { 'rustfmt' },
      sh = { 'shfmt' },
      toml = { 'taplo' },
      typescript = { 'prettierd' },
      typescriptreact = { 'prettierd' },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
  },
}
