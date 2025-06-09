vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = { '*.zig', '*.zon' },
  callback = function(ev)
    vim.lsp.buf.code_action {
      context = { only = { 'source.fixAll' } },
      apply = true,
    }

    -- vim.lsp.buf.code_action {
    --   context = { only = { 'source.organizeImports' } },
    --   apply = true,
    -- }
  end,
})
