return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = { 'folke/snacks.nvim', 'nvim-mini/mini.completion' },
  config = function()
    require 'core.lsp'

    vim.lsp.config('*', {
      capabilities = require('mini.completion').get_lsp_capabilities(),
    })
    vim.lsp.enable { 'clangd', 'cssls', 'html', 'yamlls', 'jsonls', 'bashls', 'lua_ls', 'taplo', 'zls' }
  end,
}
