return {
  'stevearc/conform.nvim',
  lazy = true,
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    formatters_by_ft = {
      lua = { 'stylua' },
      rust = { 'rustfmt' },
      -- javascript = { "prettier" },
      -- javascriptreact = { "prettier" },
      -- typescript = { "prettier" },
      -- typescriptreact = { "prettier" },
      -- css = { "prettier" },
      -- html = { "prettier" },
      -- json = { "prettier" },
      sh = { 'shfmt' },
      go = { 'gofumpt', 'goimports' },
      proto = { 'buf' },
      -- php = { "pint" },
      -- toml = { "taplo" },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = false,
    },
  },
}
