return {
  'nvimtools/none-ls.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local null_ls = require 'null-ls'

    local d = null_ls.builtins.diagnostics

    null_ls.setup {
      d.shellcheck,
      d.buf,
      d.golangci_lint,
      d.jsonlint,
    }
  end,
}
